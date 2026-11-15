#!/usr/bin/env python3
"""Build one-page SVG overviews of each technique.

Step names and pushback zones are read from references/<technique>.md, so the
picture cannot drift from the protocol. Only the short captions come from
assets/overviews/captions.json.

    build_overviews.py            write assets/overviews/<technique>.svg
    build_overviews.py --check    exit 1 if captions and protocol files disagree,
                                  or if the SVG files are out of date

The SVG avoids <defs>, gradients, filters and rgba() so that it also loads in
Fabric.js-based editors.
"""
import json
import re
import sys
from pathlib import Path
from xml.sax.saxutils import escape

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "assets" / "overviews"
W, H, M = 1200, 800, 60
INK, GREY, LIGHT, WARN = "#1a1a1a", "#5f5f5f", "#c9c9c9", "#a3261d"
FONT = "Helvetica, Arial, sans-serif"

STEP_RE = re.compile(r"^## Step (\d+): (.+)$", re.M)
ZONE_RE = re.compile(r"[Zz]one:\**\s*\**\s*(Core|Supportive|Closing)")


def read_steps(technique):
    """Return [(number, name, zone)] for steps 1..N of a protocol file."""
    text = (ROOT / "references" / f"{technique}.md").read_text()
    found = list(STEP_RE.finditer(text))
    steps = []
    for i, m in enumerate(found):
        number = int(m.group(1))
        if number == 0:  # conditional pre-step, not part of the main flow
            continue
        end = found[i + 1].start() if i + 1 < len(found) else len(text)
        zone = ZONE_RE.search(text[m.end():end])
        name = re.sub(r"\*+", "", m.group(2)).strip()
        name = re.sub(r"\s*\(.*\)$", "", name)
        steps.append((number, name, zone.group(1) if zone else "Supportive"))
    return steps


def wrap(text, width_px, size):
    """Greedy wrap using an average glyph width; good enough for sans-serif."""
    limit = max(8, int(width_px / (size * 0.50)))
    lines, line = [], ""
    for word in text.split():
        if line and len(line) + 1 + len(word) > limit:
            lines.append(line)
            line = word
        else:
            line = f"{line} {word}".strip()
    return lines + [line] if line else lines


def text(x, y, s, size, fill=INK, weight="normal", anchor="start", spacing=None):
    extra = f' letter-spacing="{spacing}"' if spacing else ""
    return (f'<text x="{x}" y="{y}" font-family="{FONT}" font-size="{size}" '
            f'font-weight="{weight}" fill="{fill}" text-anchor="{anchor}"{extra}>{escape(s)}</text>')


def bullet_list(x, y, label, items, width, label_fill=GREY):
    out = [text(x, y, label, 11, label_fill, "bold", spacing="1.5")]
    y += 26
    for item in items:
        lines = wrap(item, width - 18, 15)
        out.append(f'<line x1="{x}" y1="{y - 5}" x2="{x + 8}" y2="{y - 5}" stroke="{INK}" stroke-width="1.2"/>')
        for line in lines:
            out.append(text(x + 18, y, line, 15))
            y += 21
        y += 7
    return out, y + 16


def build(technique, cap):
    steps = read_steps(technique)
    out = [f'<svg xmlns="http://www.w3.org/2000/svg" width="{W}" height="{H}" viewBox="0 0 {W} {H}">',
           f'<rect x="0" y="0" width="{W}" height="{H}" fill="#ffffff"/>',
           text(M, 88, cap["title"], 34, weight="bold"),
           text(M, 116, cap["meta"], 15, GREY),
           f'<line x1="{M}" y1="140" x2="{W - M}" y2="140" stroke="{INK}" stroke-width="1.2"/>']

    # Left column: when, when not, what you leave with.
    left_w = 330
    block, y = bullet_list(M, 184, "USE WHEN", cap["use_when"], left_w)
    out += block
    block, y = bullet_list(M, y, "NOT WHEN", cap["not_when"], left_w, WARN)
    out += block
    out.append(text(M, y, "YOU LEAVE WITH", 11, GREY, "bold", spacing="1.5"))
    for i, line in enumerate(wrap(cap["leave_with"], left_w, 15)):
        out.append(text(M, y + 26 + i * 21, line, 15))

    # Right column: the step flow.
    cx, tx = 494, 532
    top, bottom = 206, 706
    exits = {e["after"]: e["text"] for e in cap.get("exits", [])}
    units = len(steps) + 0.55 * len(exits)
    row = min(92, (bottom - top) / max(units - 0.4, 1))
    out.append(text(cx - 17, 184, "STEPS", 11, GREY, "bold", spacing="1.5"))

    y = top + 14
    centres = []
    body = []
    for number, name, zone in steps:
        core = zone == "Core"
        centres.append(y)
        body.append(f'<circle cx="{cx}" cy="{y}" r="17" fill="#ffffff" stroke="{INK}" '
                    f'stroke-width="{3 if core else 1.2}"/>')
        body.append(text(cx, y + 5, str(number), 14, weight="bold", anchor="middle"))
        body.append(text(tx, y - 3, name, 17, weight="bold"))
        for i, line in enumerate(wrap(cap["steps"][str(number)], W - M - tx, 13.5)[:2]):
            body.append(text(tx, y + 17 + i * 17, line, 13.5, GREY))
        y += row
        if number in exits:
            dy = y - row * 0.36
            body.append(f'<polygon points="{cx},{dy - 7} {cx + 7},{dy} {cx},{dy + 7} {cx - 7},{dy}" '
                        f'fill="#ffffff" stroke="{INK}" stroke-width="1.2"/>')
            body.append(f'<line x1="{cx + 7}" y1="{dy}" x2="{tx - 8}" y2="{dy}" stroke="{INK}" '
                        f'stroke-width="1.2" stroke-dasharray="3 3"/>')
            body.append(text(tx, dy + 4.5, exits[number], 13.5, INK, "normal"))
            y += row * 0.55
    # The connector goes behind the circles.
    out.append(f'<line x1="{cx}" y1="{centres[0]}" x2="{cx}" y2="{centres[-1]}" stroke="{LIGHT}" stroke-width="1.2"/>')
    out += body

    # Footer: legend and the standing reminder.
    fy = 742
    out.append(f'<line x1="{M}" y1="{fy - 22}" x2="{W - M}" y2="{fy - 22}" stroke="{LIGHT}" stroke-width="1"/>')
    out.append(f'<circle cx="{M + 8}" cy="{fy - 4}" r="7" fill="#ffffff" stroke="{INK}" stroke-width="3"/>')
    out.append(text(M + 24, fy, "core step — the work happens here", 12, GREY))
    lx = M + 252
    out.append(f'<polygon points="{lx},{fy - 10} {lx + 6},{fy - 4} {lx},{fy + 2} {lx - 6},{fy - 4}" '
               f'fill="#ffffff" stroke="{INK}" stroke-width="1.2"/>')
    out.append(text(lx + 14, fy, "a branch or exit", 12, GREY))
    out.append(text(W - M, fy, "A practice tool, not therapy. Safety comes before every step.", 12, GREY, anchor="end"))
    out.append("</svg>")
    return "\n".join(out) + "\n"


def main():
    check = "--check" in sys.argv
    captions = json.loads((OUT / "captions.json").read_text())
    problems = []
    for technique, cap in captions.items():
        if not (ROOT / "references" / f"{technique}.md").exists():
            problems.append(f"{technique}: no references/{technique}.md")
            continue
        numbers = {str(n) for n, _, _ in read_steps(technique)}
        if numbers != set(cap["steps"]):
            problems.append(f"{technique}: protocol has steps {sorted(numbers)}, captions have {sorted(cap['steps'])}")
            continue
        svg = build(technique, cap)
        target = OUT / f"{technique}.svg"
        if check:
            if not target.exists() or target.read_text() != svg:
                problems.append(f"{technique}: {target.name} is out of date — run scripts/build_overviews.py")
        else:
            target.write_text(svg)
            print(f"wrote {target.relative_to(ROOT)}")
    for p in problems:
        print(f"ERROR {p}", file=sys.stderr)
    sys.exit(1 if problems else 0)


if __name__ == "__main__":
    main()
