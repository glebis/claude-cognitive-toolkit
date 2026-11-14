# Behavioral Activation

A 6-step planning exercise from Behavioral Activation (Martell, Dimidjian, & Herman-Dunn, 2010, *Behavioral Activation for Depression: A Clinician's Guide*), building on Lewinsohn's earlier work on pleasant-activity scheduling. When mood is low people do less, and doing less tends to keep mood low; the exercise plans one small, scheduled activity chosen by what matters to the user, on the principle that action comes first and motivation follows. Use "research suggests" and "tends to", never "this will lift your mood".

Session duration: roughly 8 minutes.

---

## When to Recommend

- User has low energy, flatness, or a sense of "nothing much"
- User is withdrawing: fewer messages, fewer plans, staying in
- User says "I don't feel like doing anything"
- User describes days shrinking to the minimum (work, sleep, repeat)

---

## When NOT to use

- **Safety concerns** (suicidal ideation, self-harm intent, imminent danger): follow the Safety section of `session-engine.md`. No technique.
- **Acute distress** (panic, overwhelm): settle first, as described in the Safety section of `session-engine.md`. Offer this exercise only once they say they have settled.
- **Tiredness that is physical or earned** (illness, sleep deprivation, burnout, overwork, grief in its first days): rest is the right activity. Do not prescribe activation against a body that needs recovery. Ask before assuming — Step 2 does this.
- **Low mood most of the day for two weeks or more, or not being able to function** (work, eating, self-care): say once, plainly and without diagnosing, that this is worth taking to a doctor or therapist. The exercise can continue alongside. Do not repeat it.

---

## Pushback Zones Reference

See `pushback-config.md` for full level behavior. Pushback zones for this technique:

| Step | Name | Zone |
|------|------|------|
| 0 | Follow-up on the last plan | none (conditional) |
| 1 | What Has Dropped Away | Supportive |
| 2 | Rest Check | Supportive (never push back on a need for rest) |
| 3 | What Matters | **Core** |
| 4 | One Activity, Made Small | **Core** |
| 5 | Predict | Supportive |
| 6 | Barriers | Supportive |
| — | Close | Closing |

---

## Step 0: Follow-up on the last plan

Runs only when the most recent saved Behavioral Activation session in the sessions folder (path in `session-engine.md`) has a planned activity and no recorded result, meaning no `## Follow-up` section. Otherwise skip silently and start at Step 1.

**Prompt:**
> "Last time you planned [activity] for [day]. Did you get to do it?"

**If yes:**
> "How much did you enjoy it, 0–10? And how much sense of accomplishment?"

Compare with the prediction, neutrally: "You expected [N] for enjoyment and it was [M]." Do not interpret the gap. If actual is higher than predicted, you may add: "That's useful data — low mood tends to predict low." If it is the same or lower, say "Good to know. That's real information about this activity."

**If no:**
> "What got in the way?"

No reproach, no "why not". Treat the answer as information and carry it into Step 6 as the likely barrier.

**Save:** append to the earlier session file under a `## Follow-up` heading with the date:

```markdown
## Follow-up (YYYY-MM-DD)

- Done: [yes / no / partial]
- Actual enjoyment / accomplishment: [N / N, or n/a]
- What got in the way: [text, or n/a]
```

---

## Step 1: What Has Dropped Away

**Zone: Supportive** — gentle pushback only (max 1 exchange)

**Prompt:**
> "Think back a month, or a year. What did you do then that you've stopped doing?"

**Follow-ups:**

- **"Nothing" or blank**: offer areas as prompts: "People — seeing or messaging someone? Body — walking, stretching, sport? Things you enjoy — music, games, a hobby? Things that gave a sense of having done something? Upkeep — cooking, the flat, admin?"

---

## Step 2: Rest Check

**Zone: Supportive** — never push back on a need for rest

**Prompt:**
> "Before we plan anything: is the low energy asking for recovery? For example illness, short sleep, a long stretch of overwork, or a recent loss."

**If yes (recovery is needed):**
> "Then rest is the plan. Let's make it a deliberate one: what would a good rest look like, and when? Guilt-free, with a start and an end."

Help them pick one specific rest (a nap, an evening off, a day without messages), with a time. Do not move on to activation. Exit here and record `outcome: justified-exit`.

**If no or unsure:** proceed to Step 3. If unsure, say: "OK. We'll keep it small, and if it turns out your body needs rest, that counts as the plan."

If the user mentions that low mood has lasted most of the day for two weeks or more, or that they cannot function, say the doctor-or-therapist line from "When NOT to use" once here, then continue.

---

## Step 3: What Matters

**Zone: Core** — pushback applies fully

**Prompt:**
> "From the list, which area matters to you? Not one you should do — one that matters to you."

**Follow-ups:**

- **Several areas**: "Which one would you miss most if it never came back?"
- **Unsure**: "Which of these, when it was part of your week, made the week feel more like yours?"

**Pushback per level when the answer is a "should"** ("I should exercise", "I ought to call my mother"):

- **Level 0:** Accept it and move on.
- **Level 1:** "That sounds like a 'should'. Is there a part of it that you'd want for yourself?"
- **Level 2:** "I notice that's a 'should'. Those tend to be hard to start, because the push comes from outside. What's one thing in this area you'd actually like?"
- **Level 3:** As level 2, plus: "What makes it hard to name something you want?" If the user engages, work with it, then return to the question once.

**Pushback per level when the answer is "nothing matters":** do not argue at any level. Go smaller and more neutral: "That's OK. Let's lower the bar. What was least bad this week? Even a slightly less awful moment." Build the area from that answer. At level 3 you may add one question: "What is it like when nothing feels worth doing?" Then continue.

---

## Step 4: One Activity, Made Small

**Zone: Core**

**Prompt:**
> "Pick one specific activity in that area. 5 to 20 minutes, doable today or tomorrow. When, and where?"

The plan needs a day, a time and a place. Then ask:
> "How confident are you that you'll do it, 0–10?"

If confidence is below 7, shrink the activity and ask again: "What would make it a 7? Shorter, easier, with someone, or just the first step?" Repeat until confidence is 7/10 or more. Record the final number.

**Pushback per level when the plan is vague** ("exercise more", "see people") **or oversized** ("clean the whole flat", "an hour at the gym"):

- **Level 0:** Accept it and move on.
- **Level 1:** "Could we make that more specific — one thing, one time?"
- **Level 2:** "That's a big one for a day with low energy. What's the smallest version you could do in 10 minutes, at a set time?"
- **Level 3:** As level 2, plus: "What would stop you from doing the small version?" If the user engages, work with it, then return to the plan once.

---

## Step 5: Predict

**Zone: Supportive** — gentle pushback only (max 1 exchange)

**Prompt:**
> "How much do you expect to enjoy it, 0–10? And how much sense of accomplishment, 0–10?"

Record both numbers. Explain in one line: "Low mood tends to predict low, so we write the guess down and compare it with what actually happens. The comparison is the data."

**Follow-ups:**

- **"Zero" or "I won't enjoy it"**: accept the number as given. "OK, zero it is. We'll see what the actual number turns out to be."

---

## Step 6: Barriers

**Zone: Supportive** — gentle pushback only (max 1 exchange)

**Prompt:**
> "What is most likely to stop you?"

Then build one if-then plan for that single barrier:

> "If [barrier happens], then I will [specific response]."

**Follow-ups:**

- **"Nothing will stop me"**: "Good. If something did, what would it most likely be?" Ask once, then accept.
- **The barrier is "I won't feel like it"**: "That one is nearly certain, so plan for it. What is the first 2 minutes of the activity? The if-then can be: if I don't feel like it, I do only those 2 minutes."
- **Barrier carried over from Step 0**: use what got in the way last time.

---

## Close

Restate the plan in one sentence: "So: [activity], [day] at [time], [place]. If [barrier], then [response]."

No pressure and no accountability language. Say plainly: "If it doesn't happen, that's information, not failure. We can look at what got in the way next time." Then follow Phase 4 of `session-engine.md` (summary, takeaway, re-rate, save). The takeaway is the plan itself.

---

## Session Output Body

Body template for the saved session. Frontmatter, filename and path are defined once in `session-engine.md`. The Follow-up section is appended later by Step 0.

```
- Dropped away: [what they named]
- Rest check: [needed rest / not needed / unsure]
- Area that matters: [named]
- Planned activity: [specific activity]
- When/where: [day, time, place]
- Confidence (0–10): [N]
- Predicted enjoyment / accomplishment: [N / N]
- Barrier + if-then: [barrier; if ..., then ...]
```

This technique has no emotion rating of its own, so the check-in and close ratings from `session-engine.md` supply `pre_intensity` and `post_intensity`. Record `outcome: completed` when a plan was made, `outcome: justified-exit` when rest was planned in Step 2 (leave the activity fields as `n/a — rest planned: ...`), or `outcome: stopped-early` when the user ended before a plan was set.

Skipped steps: log with `[skipped]` in the relevant field and list them in `steps_skipped`.
