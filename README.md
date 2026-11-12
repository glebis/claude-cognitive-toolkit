# Claude Cognitive Toolkit

Guided CBT and DBT practice exercises for AI assistants. A Claude Code skill that walks you through a thought record or an opposite-action exercise in the terminal (or over Telegram) and saves the result as markdown.

It is a practice tool for between therapy sessions. It is not a therapist and does not diagnose.

---

## What's in it

| Technique | Type | Steps | Time | Status |
|---|---|---|---|---|
| Thought Record | CBT | 7 | 10–15 min | ✅ Available |
| Opposite Action | DBT | 4 | ~5 min | ✅ Available |
| TIPP | DBT | — | — | Planned |
| DEAR MAN (with roleplay) | DBT | — | — | Planned |
| Behavioral Activation | CBT | — | — | Planned |
| Chain Analysis | DBT | — | — | Planned |
| Wise Mind | DBT | — | — | Planned |

Planned techniques have no protocol yet. The skill will tell you so rather than improvise one.

---

## Thought Record

A 7-step cognitive restructuring exercise based on Beck's cognitive therapy and the worksheet format from Greenberger & Padesky's *Mind Over Mood*.

1. **Situation** — what happened, as a camera would record it
2. **Automatic thought** — the raw thought in the moment
3. **Emotion** — name it and rate its intensity, 0–10
4. **Evidence for** the thought
5. **Evidence against** the thought
6. **Balanced thought** — a more complete view, not positive thinking
7. **Re-rate** the emotion, 0–10

Two things happen around those steps:

- **Distortion classification is silent.** The automatic thought is classified against Burns' ten cognitive distortions and the result is written to the saved session. It is not announced during the exercise — the Socratic questions do that work.
- **Accuracy check.** If the evidence shows the thought is simply true (a real loss, a real threat, a real mistake), the exercise stops trying to restructure it and moves to problem-solving or coping instead.

## Opposite Action

A 4-step DBT emotion-regulation skill (Linehan): name the emotion, identify the action urge, check whether the urge is justified by the facts, and — only if it is not — act opposite to it. If the urge is justified, the exercise helps you act on it skillfully instead.

---

## Pushback

When you try to skip an uncomfortable step, the skill can hold the frame for a moment before yielding. It always yields.

| Level | Name | Behavior |
|---|---|---|
| 0 | `off` | No pushback; `skip` advances at once |
| 1 | `gentle` | One soft redirect |
| 2 | `moderate` | Two attempts from different angles (default) |
| 3 | `firm` | Three exchanges, including one about what makes the step hard |

Set it per session with `/cbt --pushback firm`, or say `softer`, `harder`, or `no pushback` mid-session. Pushback is switched off entirely during safety responses and the accuracy check.

---

## Quick Start

### Claude Code

```bash
git clone https://github.com/glebis/claude-cognitive-toolkit.git ~/.claude/skills/cognitive-toolkit
```

Then, in Claude Code:

```
/cbt                    # check-in, then a recommended technique
/cbt thought-record     # go straight to a thought record
/cbt opposite-action    # go straight to opposite action
```

### Telegram (via Hermes)

See [hermes/setup-mac-mini.md](hermes/setup-mac-mini.md). Commands: `/record`, `/opposite`, `/checkin`, `/settings`.

An optional script, [scripts/nudge-check.sh](scripts/nudge-check.sh), decides when a check-in message is due. It only nudges someone who has used the toolkit before, backs off when nudges go unanswered, and supports opt-out and snooze.

---

## Output

Each session is saved to `~/Brains/brain/cognitive-toolkit/sessions/` as `YYYYMMDD-[technique]-NN.md`. To use a different folder, change the path in [references/session-engine.md](references/session-engine.md) — it is defined only there.

```markdown
---
type: cognitive-toolkit-session
technique: thought-record
date: 2026-04-26
time: "14:30"
channel: cli
pushback_level: moderate
pre_intensity: 7
post_intensity: 4
intensity_delta: -3
emotions: [anxiety]
distortions_identified: [all-or-nothing, fortune-telling]
steps_completed: 7
steps_skipped: []
outcome: completed
---

**Situation**
...

**Automatic Thought**
...

**Evidence FOR**
...

**Evidence AGAINST**
...

**Balanced Thought**
...

## Takeaway
...
```

---

## Health Data (optional)

If a health MCP is available, the skill can read your latest HRV at check-in and compare it with your own recent baseline. A below-baseline reading is mentioned once as context; nothing else changes. See [references/health-integration.md](references/health-integration.md).

The skill does not compare HRV before and after a session (wearable sampling is too sparse for that to mean anything) and does not use genetic data.

---

## Privacy

Sessions are written as local markdown files. The conversation itself goes to whichever model provider runs the skill, and to Telegram if you use the Telegram channel — so this is local storage, not local processing.

---

## Safety

This toolkit implements publicly documented self-help techniques. It is not a substitute for professional mental health care, and it does not diagnose.

If you express suicidal thoughts or imminent danger, the skill stops the exercise and points you to emergency services and a crisis line; it cannot do more than that. If you are in crisis, contact your local emergency number or a crisis line directly — [findahelpline.com](https://findahelpline.com) lists them by country.

---

## License

MIT — see [LICENSE](LICENSE)

## Citation

See [CITATION.cff](CITATION.cff).
