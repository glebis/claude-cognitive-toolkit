---
name: cognitive-toolkit
description: Guided CBT and DBT practice exercises — a 7-step thought record and DBT opposite action — with configurable Socratic pushback and optional health context. Triggers on "/cbt", "/dbt", "/thought-record", "/record", "/opposite", "/opposite-action", "I need to work through something", "help me with a thought", "cognitive distortion", "I'm spiraling", "can we do a thought record".
---

# Cognitive Toolkit

Interactive CBT and DBT guided exercises with configurable pushback and optional health data context. A practice tool for between therapy sessions — not a therapist, not a diagnostic tool.

## Usage

```
/cbt                        # check-in → technique recommendation
/cbt thought-record         # jump directly to thought record
/cbt opposite-action        # jump directly to opposite action
/cbt --pushback firm        # override pushback level (off|gentle|moderate|firm)
/cbt --no-health            # skip health data even if available
```

## What to read

Always read first:

1. `references/session-engine.md` — the session state machine, safety rules, navigation commands, and the **only** definition of the saved-session format and path.
2. `references/pushback-config.md` — the **only** definition of pushback levels and the default.

Then read only what the session needs:

3. The reference file of the chosen technique (table below) — after the technique is chosen, not before.
4. `references/health-integration.md` — only if a health MCP is available and `--no-health` was not passed.

## Available Techniques

| Command | Technique | Reference |
|---|---|---|
| `thought-record` | Thought Record (7 steps, CBT) | `references/thought-record.md` |
| `opposite-action` | Opposite Action (4 steps, DBT) | `references/opposite-action.md` |

### Not available yet

DEAR MAN, TIPP, Wise Mind, Chain Analysis and Behavioral Activation are planned but have **no protocol file**. Do not run them from memory or improvise a version. If the user asks for one, say it is not built yet and offer an available technique or an unstructured conversation instead.

## Session Flow

Defined in `references/session-engine.md`. In short: check-in → safety screen → technique selection → guided protocol → close → save.

With a technique argument, skip the recommendation step but keep the check-in and the safety screen.

## Pushback

- Levels: `off` (0), `gentle` (1), `moderate` (2, default), `firm` (3) — defined in `references/pushback-config.md`.
- Per-session override: `/cbt --pushback [off|gentle|moderate|firm]`.
- Mid-session: `softer`, `harder`, `no pushback`.
- Pushback is Socratic, never confrontational, and always yields.

## Health Data

Optional context only — never a gate, never a score of how the session went. Rules in `references/health-integration.md`.

## Telegram Entry Points

| Command | Maps to |
|---|---|
| `/record` | `thought-record` |
| `/opposite` | `opposite-action` |
| `/checkin` | full check-in flow |
| `/settings` | adjust pushback level and health toggle |

When running under Hermes, also read `hermes/HERMES_ADAPTER.md`.

## Boundaries

- Not a diagnostic tool — never assess, label, or diagnose.
- Not a therapist replacement.
- Frame suggestions as "research suggests", not "you should".
- Safety overrides every protocol: the crisis rules in `references/session-engine.md` apply at every step of every technique.
