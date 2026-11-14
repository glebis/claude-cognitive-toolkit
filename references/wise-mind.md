# Wise Mind

A 6-step DBT core mindfulness practice for a decision or a pull in two directions (Linehan, M. M. (2015). DBT Skills Training Manual, 2nd ed. — core mindfulness, "states of mind"). The user hears out emotion mind and reasonable mind separately, then looks for the position that takes both seriously. Wise mind here means "what you know when both are heard" — nothing more, and no answer is promised.

Session duration: roughly 8 minutes.

---

## When to Recommend

- User is torn between two options
- User says some version of "I know what I should do but I can't"
- User is about to decide something while very emotional
- User is over-rationalising a feeling away ("it shouldn't bother me, so it doesn't")

---

## When NOT to use

- **Acute distress** (panic, overwhelm, cannot think straight): settle first, see the Safety section of `session-engine.md`. Offer the technique only once they say they have settled.
- **Safety concerns:** follow the Safety section of `session-engine.md`. No technique.
- **The decision needs facts the user does not have yet:** say so and name what is missing ("this depends on what the landlord actually says — that's the missing piece"). Suggest getting that first, then return.
- **Decisions about medication, treatment or legal matters:** this skill can clarify what the user wants, not advise. Say that before starting, and keep any outcome as "what I want", not "what to do".

**Never say which option you think is right**, even if asked. Say plainly that it is their decision, and reflect back what they said on each side. This neutrality does not cover safety: if one of the options means staying in or returning to danger, the Safety section of `session-engine.md` applies and the exercise stops.

---

## Pushback Zones Reference

See `pushback-config.md` for full level behavior. Pushback zones for this technique:

| Step | Name | Zone |
|------|------|------|
| 1 | Name the Question | Supportive |
| 2 | Emotion Mind | **Core** |
| 3 | Reasonable Mind | **Core** |
| 4 | Pause | Supportive (pushback off) |
| 5 | Wise Mind | Supportive (never push for an answer) |
| 6 | One Next Step | Supportive |

---

## Step 1: Name the Question

**Zone: Supportive** — gentle pushback only (max 1 exchange)

**Prompt:**
> "What is the decision or the pull you're caught in? One sentence, as plainly as you can."

**Follow-ups:**

- **Not a real decision** ("I just feel stuck"): "If you had to put it as 'should I X or Y', what would X and Y be?"

---

## Step 2: Emotion Mind

**Zone: Core** — pushback applies fully

**Prompt:**
> "What does the feeling part of you say about this? Let it speak without editing."

**Key principle:** The feeling is never argued with.

**Follow-ups:**

- **Thin answer**: "What else does it want? What is it afraid of or longing for?"

**Pushback per level when the answer is reasoning dressed up as feeling** ("I feel that it would be irresponsible"):

- **Level 0:** Accept it and move on.
- **Level 1:** "That sounds a bit like a reason. What is the feeling underneath it?"
- **Level 2:** "I notice that's a reason rather than a feeling — that part comes next. For now, what does the emotional side say, even if it isn't sensible?"
- **Level 3:** As level 2, then: "What makes it hard to let the feeling say its piece without a justification attached?"

---

## Step 3: Reasonable Mind

**Zone: Core** — pushback applies fully

**Prompt:**
> "Now the other side. Facts, logic, consequences only — what does that part say?"

**Follow-ups:**

- **Only one option covered**: "And for the other option — what do the facts say there?"

**Pushback per level when feeling leaks in** ("I'd hate myself if I stayed"):

- **Level 0:** Accept it and move on.
- **Level 1:** "That sounds like a feeling. What would the facts alone say?"
- **Level 2:** "That one belongs to the emotional side, and it's already been heard. If you set it down, what's left — facts and consequences only?"
- **Level 3:** As level 2, then: "What makes it hard to keep the facts separate from the feeling here?"

**When "reasonable" is actually harsh self-criticism** ("I'm just too weak to do the sensible thing"): say it gently at every level except 0 — "That sounds like a critic more than a reasoner. A critic is not reason. What would the facts say without the verdict on you?" At level 0, reflect it back once and move on.

---

## Step 4: Pause

**Zone: Supportive** — pushback off. Accept `skip` at once.

**Prompt:**
> "Let's pause. A few slow breaths — in for 4, out for 6 to 8. Then pick one of these: ask your question on the in-breath and just listen on the out-breath; or ask yourself, 'What would I tell someone I love in exactly this spot?'"

Let the user choose. Wait for them to come back. If nothing came, say that is a normal result.

---

## Step 5: Wise Mind

**Zone: Supportive** — never push for an answer

**Prompt:**
> "What do you know when both of those are taken seriously?"

**Three valid endings:**

- **An answer:** accept it as stated. Do not improve it or add to it.
- **A smaller next step**, not a full answer: accept it as the result.
- **"Nothing yet":** accept it. Then ask: "When will you ask again?" and "Is there information you're missing that would change this?"

**Follow-ups:**

- **Answer simply repeats one side word for word**: at levels 2–3 only, ask once, neutrally: "What happened to the other side?" Then accept whatever they say. At levels 0–1, accept it.
- **Asks you which is right**: "I won't say which I think is right — it's your decision. Here is what you said for each side: [reflect]. What do you know now?"

---

## Step 6: One Next Step

**Zone: Supportive** — gentle pushback only (max 1 exchange)

**Prompt:**
> "What is one small, concrete step you could take next? Or, if waiting is the right move, decide when you'll come back to this."

**Follow-ups:**

- **Too big or vague** ("think about it"): "What is the smallest version you'd actually do, and by when?"

---

## Session Output Body

Body template for the saved session. Frontmatter, filename and path are defined once in `session-engine.md`.

```
- Question: [one sentence]
- Emotion mind: [what the feeling side said]
- Reasonable mind: [what the facts side said]
- Wise mind: [the answer or smaller step, or "nothing yet"]
- Next step / revisit time: [the step, or the named time to come back]
```

This technique has no rating of its own, so the check-in and close ratings from `session-engine.md` supply `pre_intensity` and `post_intensity`. Record `outcome: completed` when the session reached the end, including a "nothing yet" Wise mind, and `outcome: stopped-early` if the user ended it before Step 6.

Skipped steps: log `[skipped]` in the field and list them in `steps_skipped`.
