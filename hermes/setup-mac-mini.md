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
description: Evidence-based mental health self-management skills — CBT thought records, DBT emotion regulation, crisis skills, check-ins. Delivered via Telegram with configurable therapeutic pushback.
---
EOF

# Symlink the cognitive toolkit
ln -s ~/ai_projects/claude-cognitive-toolkit ~/.hermes/skills/mental-health/cognitive-toolkit
```

## 3. Create the Hermes-adapted skill file

The main skill file is written for Claude Code. For Hermes, we add an adapter that overrides the interaction model — no AskUserQuestion, just direct Telegram messages.

```bash
cat > ~/.hermes/skills/mental-health/cognitive-toolkit/HERMES_ADAPTER.md << 'ENDOFFILE'
# Hermes Adapter for Cognitive Toolkit

When running under Hermes via Telegram, override these behaviors from skill.md:

## Interaction Model

- Do NOT use AskUserQuestion or any Claude Code-specific tools
- Ask questions as regular Telegram text messages
- Wait for the user's text or voice reply before proceeding
- Voice messages will be transcribed automatically — treat the transcription as text input
- Keep messages short (2-3 sentences max per message) — Telegram is not a document viewer

## Session Flow Adaptation

Instead of the Claude Code session engine's tool-based flow:
1. Send the check-in question as a Telegram message
2. Wait for reply
3. Send technique recommendation as a message with reply options
4. For each technique step: send the prompt as a message, wait for reply, send one adaptive follow-up, wait, move on
5. At close: send summary + takeaway + mood re-rate question

## Pushback via Telegram

Same levels as pushback-config.md, but delivered as conversational text:
- Don't use bullet points or formatted lists for pushback
- Write pushback as natural speech: "I notice you want to skip this — it's usually where things shift. Want to try one piece of counter-evidence?"
- Keep it to 1-2 sentences per pushback message

## Proactive Check-ins

Hermes should proactively reach out via Telegram when:
- It's been 3+ days since the last session (check ~/Brains/brain/cognitive-toolkit/sessions/ for the latest file date)
- Time is between 10:00-20:00 CET (don't nudge at night)
- Nudge format: brief, warm, not clinical. Examples:
  - "Hey. Haven't heard from you in a few days. Quick check-in — how are things?"
  - "It's been a while. Want to do a quick thought record or just chat?"
  - "Checking in. No pressure — just here if you want to work through something."
- If user doesn't respond to a nudge within 24h, don't send another for 3 more days
- Never send more than 1 nudge per day

## Tone for Telegram

- Shorter than the reference files suggest — Telegram is chat, not therapy notes
- Use line breaks between ideas, not paragraphs
- No markdown formatting (bold, headers) — plain text only
- Emoji sparingly: a single 🫶 or 💪 at session end is fine, not throughout

## Voice Messages

If the user sends a voice message:
- Treat the transcription as the response
- If transcription seems garbled, ask: "I might have misheard that — could you say it again or type it?"
- Respond with text by default (not voice) unless the user asks for voice replies

## Health Data

The Mac Mini has Health MCP running locally. Use it for HRV context:
- mcp__health__latest_vitals for pre/post HRV
- Only mention HRV if the delta is significant (>15 points)
- Don't overwhelm with numbers — "Your HRV went up nicely after that" not "HRV increased from 42 to 58, delta +16"

## Session Storage

Save sessions to the same vault path: ~/Brains/brain/cognitive-toolkit/sessions/
Same frontmatter format as session-engine.md, but add `channel: telegram` and `runtime: hermes`
ENDOFFILE
```

## 4. Set up proactive nudge cron

```bash
# Create the nudge check script
cat > ~/ai_projects/claude-cognitive-toolkit/scripts/nudge-check.sh << 'ENDOFSCRIPT'
#!/bin/bash
# Check if a proactive nudge should be sent via Hermes

SESSIONS_DIR="$HOME/Brains/brain/cognitive-toolkit/sessions"
NUDGE_STATE="$HOME/.hermes/state/cognitive-toolkit-last-nudge"

mkdir -p "$(dirname "$NUDGE_STATE")"

# Get current hour (CET)
HOUR=$(TZ=Europe/Berlin date +%H)
if [ "$HOUR" -lt 10 ] || [ "$HOUR" -gt 20 ]; then
    exit 0  # Outside nudge window
fi

# Find last session date
if [ -d "$SESSIONS_DIR" ] && [ "$(ls -A "$SESSIONS_DIR" 2>/dev/null)" ]; then
    LAST_SESSION=$(ls -t "$SESSIONS_DIR"/*.md 2>/dev/null | head -1)
    if [ -n "$LAST_SESSION" ]; then
        LAST_DATE=$(stat -f %m "$LAST_SESSION" 2>/dev/null || stat -c %Y "$LAST_SESSION" 2>/dev/null)
        NOW=$(date +%s)
        DAYS_AGO=$(( (NOW - LAST_DATE) / 86400 ))
    else
        DAYS_AGO=999
    fi
else
    DAYS_AGO=999
fi

# Check last nudge date
if [ -f "$NUDGE_STATE" ]; then
    LAST_NUDGE=$(cat "$NUDGE_STATE")
    NUDGE_AGO=$(( ($(date +%s) - LAST_NUDGE) / 86400 ))
else
    NUDGE_AGO=999
fi

# Nudge if: 3+ days since session AND 3+ days since last nudge
if [ "$DAYS_AGO" -ge 3 ] && [ "$NUDGE_AGO" -ge 3 ]; then
    # Signal Hermes to send a nudge
    date +%s > "$NUDGE_STATE"
    echo "NUDGE_NEEDED"
    exit 0
fi

echo "NO_NUDGE"
exit 0
ENDOFSCRIPT

chmod +x ~/ai_projects/claude-cognitive-toolkit/scripts/nudge-check.sh
```

## 5. Add cron job for daily nudge check

```bash
# Add to crontab — runs every 4 hours during daytime CET (8-20 UTC = 10-22 CET)
(crontab -l 2>/dev/null; echo "0 8,12,16,20 * * * ~/ai_projects/claude-cognitive-toolkit/scripts/nudge-check.sh | grep -q NUDGE_NEEDED && hermes telegram send --chat @glebkalinin 'Hey. It'\''s been a few days. Quick check-in — how are things? Want to do a thought record or just chat?'") | crontab -
```

## 6. Verify

```bash
# Check symlink
ls -la ~/.hermes/skills/mental-health/cognitive-toolkit/skill.md

# Check references are accessible
ls ~/.hermes/skills/mental-health/cognitive-toolkit/references/

# Check cron
crontab -l | grep nudge

# Test nudge script
~/ai_projects/claude-cognitive-toolkit/scripts/nudge-check.sh
```
