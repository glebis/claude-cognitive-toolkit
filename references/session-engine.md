# Session Engine — Cognitive Toolkit Core Protocol

The session state machine that wraps every technique. This file is the single source of truth for: session phases, safety rules, navigation commands, and the saved-session format and path. Other files point here instead of repeating these.

---

## Safety (applies at every phase and every step)

Safety overrides the protocol. Check for it at check-in and keep watching throughout.

**Suicidal ideation, self-harm intent, or imminent danger:** stop the technique immediately. Do not finish the step, do not push back, do not re-rate. Respond warmly and plainly, then give:

- Emergency services: 112 (EU) or the local emergency number
- Germany: Telefonseelsorge 0800 111 0 111 (free, 24/7)
- Elsewhere: findahelpline.com
- Offer to stay present. Do not resume the session framework.

**Acute distress without danger** (panicking, overwhelmed, cannot think straight): cognitive work is the wrong tool right now. Do not start or continue a thought record. Offer a few rounds of slow breathing with a longer exhale (in for 4, out for 6–8), or simply staying with them while it passes. Offer a technique only once they say they have settled. Never improvise a structured crisis protocol that has no reference file.

**Possible real-world danger** (the user describes threats, violence, coercion, or an unsafe person or place): their fear is information, not a distortion. Do not challenge it, do not ask for counter-evidence, and do not suggest approaching the source of the fear. See the accuracy and justified checks in the technique files.

---

## Phase 1: Check-in

Open with: *"What's going on right now? Just a sentence or two."*

Then ask for one number: *"How intense is it right now, 0–10, where 10 is the most intense?"* This is `pre_intensity`.

Techniques that rate a specific emotion themselves (Thought Record steps 3 and 7) replace this number: record the technique's pre and post ratings as `pre_intensity` and `post_intensity`, and do not ask the user to rate twice.

**Health context (optional):** if a health MCP is available and `--no-health` was not passed, follow `health-integration.md`. If unavailable, skip silently and do not mention the absence.

---

## Phase 2: Technique Selection

Map check-in signals to a technique:

| Signal | Do this |
|---|---|
| Danger, suicidal ideation, self-harm intent | Safety section above — no technique |
| Acute distress, panic, overwhelm | Safety section above — settle first |
| Rumination, spiraling, a thought that will not let go | Thought Record |
| Strong reaction that feels out of proportion | Thought Record |
| Avoidance, procrastination, urge to withdraw or lash out | Opposite Action |
| Anything else (interpersonal conflict, vague unease, low energy) | No matching technique is built yet. Say so. Offer the closer of the two available techniques if one plausibly fits, or an unstructured conversation. |

Present the recommendation with a short rationale: *"Sounds like you might be caught in a loop — a thought record tends to work well here. Want to try that, or something different?"*

The user can always override. Accept either available technique by name or abbreviation without pushback.

---

## Phase 3: Guided Protocol

Within each technique:

1. Present the step prompt.
2. Wait for the response.
3. Offer one adaptive Socratic follow-up — an open question, not a judgment.
4. Move to the next step.

**If the response is thin:** apply the rules in `pushback-config.md`. They are not repeated here.

**If the user asks "why":** explain the purpose of the current step in plain language. *"This step separates the raw event from the meaning you gave it — they are often fused, which makes the distress harder to examine."*

**Between steps:** do not summarize what was just said. Just move forward.

**Follow-up examples:**
- "What else comes up when you sit with that?"
- "If a friend described this situation, what would you notice about it?"
- "What does that feeling want you to do right now?"

---

## Phase 4: Close

1. **Summary:** 2–3 sentences in the user's own words. No new interpretations.
2. **One takeaway:** a single concrete observation from the session.
3. **Re-rate:** ask for the same 0–10 intensity (skip if the technique already did). Note the change from the start without judging it; no change is a normal outcome.
4. **Save** the session as described below.

---

## Navigation Commands

| Command | Action |
|---|---|
| `next` / `skip` | Advance without completing the current step; mark it skipped (subject to pushback level) |
| `switch to [technique]` | Abandon the current technique and start the named one from step 1 |
| `stop` / `enough` / `done` | End immediately and go to close |
| `why` | Explain the purpose of the current step |
| `harder` / `softer` | Raise or lower the pushback level by one for this session |
| `no pushback` | Set pushback to `off` for this session |
| `help` | List these commands |

---

## Saved Session Format

**Path:** `~/Brains/brain/cognitive-toolkit/sessions/` — create it if missing.

**Filename:** `YYYYMMDD-[technique-slug]-NN.md`, where `NN` is a zero-padded sequence number for that date (01, 02, …). The date in the filename is what the nudge script reads, so it must be the session date.

**Frontmatter:**

```yaml
---
type: cognitive-toolkit-session
technique: [thought-record | opposite-action]
date: YYYY-MM-DD
time: HH:MM
channel: [cli | voice | telegram]
pushback_level: [off | gentle | moderate | firm]
pre_intensity: [0-10]
post_intensity: [0-10]
intensity_delta: [post minus pre]
emotions: [list]
distortions_identified: [list, thought record only]
steps_completed: [N]
steps_skipped: [list of step names, or empty]
outcome: [completed | accurate-thought-exit | justified-exit | stopped-early | safety-stop]
hrv_context: [below-baseline | within-baseline | above-baseline]
---
```

Omit any field with no data. Omit `hrv_context` unless `health-integration.md` produced one. Never invent a value.

After a `safety-stop`, save only the frontmatter and a one-line note that the session was stopped — do not transcribe the crisis content into the vault unless the user asks.

**Body:** one section per step, using the body template in the technique's reference file, followed by:

```markdown
## Takeaway

...

## Intensity

Pre: N/10 → Post: N/10 (delta: ±N)
```

---

## Tone

- Warm but not saccharine: *"That sounds tough. Let's work with it."*
- Names patterns without diagnosing: *"That sounds like an avoidance loop"* — never *"You have avoidance disorder"*.
- *"Research suggests"* and *"tends to"* — never *"you should"*.
- Never claims to be a therapist or a substitute for therapy.
- Never interprets silence as a particular emotion.

---

*See also: `pushback-config.md` for pushback rules | `health-integration.md` for health context | technique files for step-by-step protocols.*
