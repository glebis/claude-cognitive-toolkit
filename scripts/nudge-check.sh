#!/bin/bash
# Check if a proactive CBT/DBT nudge should be sent via Telegram
# Runs from cron every 4 hours during daytime CET

SESSIONS_DIR="$HOME/Brains/brain/cognitive-toolkit/sessions"
NUDGE_STATE="$HOME/.hermes/state/cognitive-toolkit-last-nudge"

mkdir -p "$(dirname "$NUDGE_STATE")"

# Outside 10:00-20:00 CET? Skip.
HOUR=$(TZ=Europe/Berlin date +%H)
if [ "$HOUR" -lt 10 ] || [ "$HOUR" -gt 20 ]; then
    echo "NO_NUDGE (outside hours)"
    exit 0
fi

# Find last session date
DAYS_SINCE_SESSION=999
if [ -d "$SESSIONS_DIR" ] && [ "$(ls -A "$SESSIONS_DIR" 2>/dev/null)" ]; then
    LAST_SESSION=$(ls -t "$SESSIONS_DIR"/*.md 2>/dev/null | head -1)
    if [ -n "$LAST_SESSION" ]; then
        # macOS stat vs Linux stat
        LAST_DATE=$(stat -f %m "$LAST_SESSION" 2>/dev/null || stat -c %Y "$LAST_SESSION" 2>/dev/null)
        NOW=$(date +%s)
        DAYS_SINCE_SESSION=$(( (NOW - LAST_DATE) / 86400 ))
    fi
fi

# Check last nudge date
DAYS_SINCE_NUDGE=999
if [ -f "$NUDGE_STATE" ]; then
    LAST_NUDGE=$(cat "$NUDGE_STATE")
    DAYS_SINCE_NUDGE=$(( ($(date +%s) - LAST_NUDGE) / 86400 ))
fi

# Nudge if: 3+ days since session AND 3+ days since last nudge
if [ "$DAYS_SINCE_SESSION" -ge 3 ] && [ "$DAYS_SINCE_NUDGE" -ge 3 ]; then
    date +%s > "$NUDGE_STATE"
    echo "NUDGE_NEEDED (${DAYS_SINCE_SESSION}d since session, ${DAYS_SINCE_NUDGE}d since nudge)"
    exit 0
fi

echo "NO_NUDGE (${DAYS_SINCE_SESSION}d since session, ${DAYS_SINCE_NUDGE}d since nudge)"
exit 0
