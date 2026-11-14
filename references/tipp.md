# TIPP

A 4-step DBT distress tolerance skill from Marsha Linehan's DBT Skills Training Manual (Linehan, 2015, 2nd ed., "TIP skills"). It brings very high emotional arousal down fast through the body, so that thinking becomes possible again. It does not solve the problem that caused the distress; it only makes the next step possible.

Session duration: roughly 5–10 minutes.

---

## When to Recommend

- User is panicking, overwhelmed, or says they cannot think straight (acute distress without danger)
- Check-in intensity is very high (about 8–10) and the user is flooded, not reflective
- User cannot do cognitive work right now: thoughts are racing and a thought record would not land
- User asks for something to calm the body fast

---

## When NOT to use

- Suicidal ideation, self-harm intent, or imminent danger: stop and follow the Safety section of `session-engine.md`. No TIPP.
- The user is calm and wants to examine a thought or an urge: use Thought Record or Opposite Action instead.
- Cold water (T) and intense exercise (I) have their own medical exclusions in Step 2. They do not rule out the whole skill, only that part.

---

## Pushback Zones Reference

See `pushback-config.md` for full level behavior. TIPP overrides it: pushback is effectively off at every level. Do not hold the frame, do not ask what makes a step hard. If the user declines a skill, offer the next one once, then just stay with them.

| Step | Name | Zone |
|------|------|------|
| 1 | Choose One Skill | Supportive |
| 2 | Do It | Supportive |
| 3 | Re-rate Intensity | Supportive |
| 4 | What Next | Supportive |

**Style for every step:** short sentences. One instruction at a time. No "why do you feel this", no evidence questions, no cognitive work. The user needs only one of the four skills, not all of them.

---

## Step 1: Choose One Skill

**Zone: Supportive**

**Prompt:**
> "Your body is running very hot right now. Let's bring it down first. We'll use one skill, just one. I suggest slow breathing. Okay?"

**Follow-ups:**

- **Agrees or says nothing against it**: go to Paced breathing in Step 2.
- **Wants another skill**: name the options in one line: "Cold water on the face, a few minutes of hard movement, slow breathing, or tensing and releasing muscles." Let them pick one.
- **Declines the skill**: "Okay. Would [next skill] work better?" Offer once. If they decline again: "That's fine. I'm here. We don't have to do anything." Stay with them. Do not argue.
- **Asks why**: "These work through the body. Cold, hard movement, slow breath and muscle release lower arousal faster than thinking does."

---

## Step 2: Do It

**Zone: Supportive**

Give one instruction at a time. Wait for the user before the next one.

### T — Temperature

**Screen first. Ask this one question before offering anything:**
> "Before cold water: do you have a heart condition or a low heart rate, take beta blockers, have an eating disorder, or are you pregnant with medical concerns? Or are you not sure?"

If the answer is yes to any, or "not sure": "Skip this one. Check with a doctor first. Let's do slow breathing instead." Move to Paced breathing. Do not offer cold again this session.

If the answer is no:

1. "Get cold water in a bowl or the sink, or a cold pack. Cold from the tap is enough."
2. "Bend forward a little. Hold your breath, and put the cold on your face — eyes and cheeks — for about 15 to 30 seconds. No longer."
3. "Come up. Breathe out slowly."
4. Once more if they want to. Not more than a few rounds.

Never suggest ice baths or staying in cold water for long. Cold water on the face only.

### I — Intense exercise

Skip if the user is injured, ill, or has been told not to exert themselves. Otherwise:

1. "5 to 10 minutes of something that fits your body and where you are. A fast walk, stairs, jumping jacks."
2. "Push until you feel your heart rate rise. Not to exhaustion. This is not a punishment."
3. "Tell me when you're done."

### P — Paced breathing

1. "Breathe in through your nose for 4."
2. "Out slowly for 6 to 8."
3. Count a few rounds with them: "In, 2, 3, 4. Out, 2, 3, 4, 5, 6." Keep going for 2–5 minutes in total.
4. If slow breathing makes them dizzy or more panicky: "Stop. Breathe normally. That's fine." Offer a different skill once, or just stay with them.

### P — Paired muscle relaxation

1. "Start with your feet. Breathe in and tense them for about 5 seconds."
2. "Breathe out and let go."
3. Move upward: calves, thighs, stomach, hands, arms, shoulders, face. One group per breath cycle.
4. Skip any injured area.

---

## Step 3: Re-rate Intensity

**Zone: Supportive**

**Prompt:**
> "How intense is it now, 0–10? Same scale as before."

This is `post_intensity`. Do not ask again at the close.

**Follow-ups:**

- **Down, and below 7**: "Good. Your body is coming down." Go to Step 4.
- **Still 7 or higher, first skill used**: offer one different skill, once: "Would you like to try [another skill]?" Run it from Step 2, then re-rate.
- **Not coming down after two skills**: do not keep cycling. "I'm staying right here with you." Say: "If it keeps climbing or you feel unsafe, please contact a person you trust, or one of these." Then give the numbers from the Safety section of `session-engine.md` in full; the user cannot see that file. Stay present. Close as `stopped-early`.
- **No change but not worse**: "No change is a normal result. It's okay."

---

## Step 4: What Next

**Zone: Supportive**

Only once the user says they feel settled.

**Prompt:**
> "You've settled a bit. Two options: we can stop here, which is a complete session. Or, later, when you're ready, we can look at what set this off with another technique. Which do you want?"

**Follow-ups:**

- **Stop here**: close. Stopping is a complete outcome.
- **Look at it later**: "Okay. Come back when you're ready. Not now." Do not start any other technique in this session.
- **Wants to start a thought record now**: do not push into one in the same breath. "Take a few minutes first. If you still want it afterwards, we can."

---

## Session Output Body

Body template for the saved session. Frontmatter, filename and path are defined once in `session-engine.md`.

```
- Skill(s) used: [Temperature / Intense exercise / Paced breathing / Paired muscle relaxation]
- Screening answer: [answer, or "n/a — temperature not considered"]
- Intensity before/after: [N → N]
- What next: [stopped here / later technique / n/a]
```

The check-in rating from `session-engine.md` is `pre_intensity`. The Step 3 re-rate is `post_intensity`; the close does not ask again. Record `outcome: completed` when the user settled, `outcome: stopped-early` if they ended it or the intensity did not come down, and `outcome: safety-stop` if the Safety section applied.

Skipped steps: log with `[skipped]` in the relevant field and list them in `steps_skipped`.
