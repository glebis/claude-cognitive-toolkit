# Mac Mini Setup — Cognitive Toolkit for Hermes + Telegram

Run this on agents-mac-mini (100.97.18.14, user: server) to set up the CBT/DBT agent.

## 1. Clone the repo

```bash
cd ~/ai_projects
git clone https://github.com/glebis/claude-cognitive-toolkit.git
```

## 2. Create Hermes skill category and symlink

```bash
# Create mental-health category
mkdir -p ~/.hermes/skills/mental-health
cat > ~/.hermes/skills/mental-health/DESCRIPTION.md << 'EOF'
---
description: Mental health self-management practice — CBT thought records, DBT opposite action, check-ins. Delivered via Telegram with configurable pushback.
---
EOF

# Symlink the cognitive toolkit
ln -s ~/ai_projects/claude-cognitive-toolkit ~/.hermes/skills/mental-health/cognitive-toolkit
```

## 3. Hermes adapter and nudge script

Both ship in the repo — do not recreate them by hand, or they will drift from the versions under version control.

- `hermes/HERMES_ADAPTER.md` — overrides the interaction model for Telegram (plain messages, no Claude Code tools).
- `scripts/nudge-check.sh` — decides whether a proactive check-in is due.

```bash
chmod +x ~/ai_projects/claude-cognitive-toolkit/scripts/nudge-check.sh
```

## 4. How the nudge script behaves

- Prints `NUDGE_NEEDED` or `NO_NUDGE (reason)`; it never sends anything itself.
- Only nudges someone who has at least one saved session, between 10:00 and 20:00 Europe/Berlin.
- Reads the session date from the filename (`YYYYMMDD-...`), so vault syncs and edits do not reset the clock.
- Backs off when nudges go unanswered: 3, 6, then 12 days after the last one, then stops until a new session is saved.
- `--mark-sent` records a delivered nudge; `--opt-out` / `--opt-in` / `--snooze DAYS` control it; `--status` shows state.

## 5. Add cron job for daily nudge check

```bash
# Add to crontab — every 4 hours; the script itself enforces the 10:00–20:00 Berlin window.
# The nudge is recorded only if the send succeeded.
(crontab -l 2>/dev/null; echo "0 8,12,16,20 * * * S=~/ai_projects/claude-cognitive-toolkit/scripts/nudge-check.sh; \$S | grep -q NUDGE_NEEDED && hermes telegram send --chat @glebkalinin 'Hey. It'\''s been a few days. Quick check-in — how are things?' && \$S --mark-sent") | crontab -
```

## 6. Verify

```bash
# Check symlink
ls -la ~/.hermes/skills/mental-health/cognitive-toolkit/SKILL.md

# Check references are accessible
ls ~/.hermes/skills/mental-health/cognitive-toolkit/references/

# Check cron
crontab -l | grep nudge

# Test nudge script
~/ai_projects/claude-cognitive-toolkit/scripts/nudge-check.sh
~/ai_projects/claude-cognitive-toolkit/scripts/nudge-check.sh --status
```
