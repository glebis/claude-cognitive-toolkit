#!/bin/bash
# Decide whether a proactive check-in should be sent. Never sends anything itself.
#
#   nudge-check.sh              print NUDGE_NEEDED or NO_NUDGE (reason)
#   nudge-check.sh --mark-sent  record that a nudge was delivered (call after a successful send)
#   nudge-check.sh --opt-out    stop all nudges until --opt-in
#   nudge-check.sh --opt-in     allow nudges again
#   nudge-check.sh --snooze N   no nudges for N days
#   nudge-check.sh --status     show state
#
# Rules:
#   - only between 10:00 and 20:00 Europe/Berlin
#   - only for someone with at least one saved session
#   - session date comes from the filename (YYYYMMDD-...), not file mtime
#   - first nudge 3+ days after the last session; if unanswered, the next waits
#     6 days, the one after 12 days, then nudging stops until a new session
#
# Overridable for testing: COGTK_SESSIONS_DIR, COGTK_STATE_DIR, COGTK_NOW (epoch).

SESSIONS_DIR="${COGTK_SESSIONS_DIR:-$HOME/Brains/brain/cognitive-toolkit/sessions}"
STATE_DIR="${COGTK_STATE_DIR:-$HOME/.hermes/state}"
NUDGE_LOG="$STATE_DIR/cognitive-toolkit-last-nudge"   # one epoch per line, newest last
OPT_OUT="$STATE_DIR/cognitive-toolkit-opt-out"
SNOOZE="$STATE_DIR/cognitive-toolkit-snooze-until"
NOW="${COGTK_NOW:-$(date +%s)}"
DAY=86400
MAX_UNANSWERED=3

mkdir -p "$STATE_DIR"

# epoch -> formatted string in Berlin time (BSD date first, then GNU)
fmt_epoch() {
    TZ=Europe/Berlin date -r "$1" "+$2" 2>/dev/null || TZ=Europe/Berlin date -d "@$1" "+$2"
}

# YYYYMMDD -> epoch at local midnight Berlin
day_to_epoch() {
    TZ=Europe/Berlin date -j -f "%Y%m%d %H%M%S" "$1 000000" +%s 2>/dev/null \
        || TZ=Europe/Berlin date -d "$1" +%s 2>/dev/null
}

# Newest session date (YYYYMMDD) taken from filenames; empty if none.
last_session_day() {
    [ -d "$SESSIONS_DIR" ] || return 0
    for f in "$SESSIONS_DIR"/[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-*.md; do
        [ -e "$f" ] || continue
        basename "$f" | cut -c1-8
    done | sort | tail -1
}

case "$1" in
    --mark-sent) echo "$NOW" >> "$NUDGE_LOG"; echo "MARKED_SENT"; exit 0 ;;
    --opt-out)   : > "$OPT_OUT"; echo "OPTED_OUT"; exit 0 ;;
    --opt-in)    [ -e "$OPT_OUT" ] && mv "$OPT_OUT" "$OPT_OUT.removed"; : > "$SNOOZE"; echo "OPTED_IN"; exit 0 ;;
    --snooze)
        case "$2" in ''|*[!0-9]*) echo "usage: $0 --snooze DAYS" >&2; exit 2 ;; esac
        echo $(( NOW + $2 * DAY )) > "$SNOOZE"; echo "SNOOZED ${2}d"; exit 0 ;;
    --status|"") ;;
    *) echo "unknown option: $1" >&2; exit 2 ;;
esac

decide() {
    if [ -e "$OPT_OUT" ]; then echo "NO_NUDGE (opted out)"; return; fi

    SNOOZE_UNTIL=$(cat "$SNOOZE" 2>/dev/null)
    if [ -n "$SNOOZE_UNTIL" ] && [ "$NOW" -lt "$SNOOZE_UNTIL" ]; then
        echo "NO_NUDGE (snoozed until $(fmt_epoch "$SNOOZE_UNTIL" %Y-%m-%d))"; return
    fi

    HOUR=$(fmt_epoch "$NOW" %H)
    HOUR=$((10#$HOUR))
    if [ "$HOUR" -lt 10 ] || [ "$HOUR" -ge 20 ]; then
        echo "NO_NUDGE (outside 10:00-20:00)"; return
    fi

    LAST_DAY=$(last_session_day)
    if [ -z "$LAST_DAY" ]; then echo "NO_NUDGE (no sessions yet)"; return; fi

    LAST_EPOCH=$(day_to_epoch "$LAST_DAY")
    if [ -z "$LAST_EPOCH" ]; then echo "NO_NUDGE (unreadable session date $LAST_DAY)"; return; fi

    DAYS_SINCE_SESSION=$(( (NOW - LAST_EPOCH) / DAY ))
    if [ "$DAYS_SINCE_SESSION" -lt 3 ]; then
        echo "NO_NUDGE (${DAYS_SINCE_SESSION}d since session)"; return
    fi

    # Nudges sent after the day of the last session are unanswered.
    UNANSWERED=0
    LAST_NUDGE=""
    if [ -f "$NUDGE_LOG" ]; then
        while read -r t; do
            case "$t" in ''|*[!0-9]*) continue ;; esac
            if [ "$t" -ge $(( LAST_EPOCH + DAY )) ]; then
                UNANSWERED=$(( UNANSWERED + 1 ))
                LAST_NUDGE=$t
            fi
        done < "$NUDGE_LOG"
    fi

    if [ "$UNANSWERED" -ge "$MAX_UNANSWERED" ]; then
        echo "NO_NUDGE (${UNANSWERED} unanswered nudges; waiting for a new session)"; return
    fi

    if [ "$UNANSWERED" -gt 0 ]; then
        GAP=$(( 3 * (1 << UNANSWERED) ))   # 6, then 12 days
        DAYS_SINCE_NUDGE=$(( (NOW - LAST_NUDGE) / DAY ))
        if [ "$DAYS_SINCE_NUDGE" -lt "$GAP" ]; then
            echo "NO_NUDGE (${DAYS_SINCE_NUDGE}d since last nudge, next after ${GAP}d)"; return
        fi
    fi

    echo "NUDGE_NEEDED (${DAYS_SINCE_SESSION}d since session, ${UNANSWERED} unanswered)"
}

decide
exit 0
