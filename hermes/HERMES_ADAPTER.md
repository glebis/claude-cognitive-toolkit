# Hermes Adapter for Cognitive Toolkit

When running under Hermes via Telegram, override these behaviors from SKILL.md:

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
3. Send technique recommendation as a message
4. For each technique step: send the prompt as a message, wait for reply, send one adaptive follow-up, wait, move on
5. At close: send summary + takeaway + the 0–10 intensity re-rate question (skip it if the technique already asked)

## Pushback via Telegram

Same levels as pushback-config.md, but delivered as conversational text:
- Don't use bullet points or formatted lists for pushback
- Write pushback as natural speech: "I notice you want to skip this — it's usually where things shift. Want to try one piece of counter-evidence?"
- Keep it to 1-2 sentences per pushback message

## Proactive Check-ins

The decision to nudge is made by `scripts/nudge-check.sh`, not by the model. Do not nudge on your own judgment.

- The script prints `NUDGE_NEEDED` or `NO_NUDGE (reason)`. Send a nudge only on `NUDGE_NEEDED`.
- After the message is actually delivered, run `scripts/nudge-check.sh --mark-sent`. If delivery failed, do not mark it.
- The script only nudges people who have used the toolkit before, backs off when nudges go unanswered (3, then 6, then 12 days, then stops until the next session), and respects opt-out.
- If the user says "stop checking in" or similar: run `scripts/nudge-check.sh --opt-out` and confirm. "Not this week" → `--snooze 7`. "You can check in again" → `--opt-in`.
- Nudge format: brief, warm, not clinical, always easy to ignore. Examples:
  - "Hey. Haven't heard from you in a few days. Quick check-in — how are things?"
  - "Checking in. No pressure — just here if you want to work through something."
- Every third nudge or so, add: "Say 'stop checking in' if you'd rather I didn't."

## Tone for Telegram

- Shorter than the reference files suggest — Telegram is chat, not therapy notes
- Use line breaks between ideas, not paragraphs
- No markdown formatting (bold, headers) — plain text only
- Emoji sparingly: a single warmth emoji at session end is fine, not throughout

## Voice Messages

If the user sends a voice message:
- Treat the transcription as the response
- If transcription seems garbled, ask: "I might have misheard that — could you say it again or type it?"
- Respond with text by default unless the user asks for voice replies

## Health Data

Follow `references/health-integration.md`. In short: HRV is context at check-in only, compared with the user's own baseline. Never compare HRV before and after a session, and never tell the user their HRV improved because of the exercise.

## Session Storage

Path, filename and frontmatter as defined in references/session-engine.md, plus:
- `channel: telegram`
- `runtime: hermes`
