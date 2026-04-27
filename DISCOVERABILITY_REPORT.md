# GitHub Discoverability Report
**glebis/claude-cognitive-toolkit** · Generated 2026-04-27

---

## 1. Repo Stats

| Metric | Value |
|---|---|
| Stars | 0 |
| Forks | 0 |
| Watchers | 0 |
| Language | Shell |
| Created | 2026-04-26 (1 day old) |
| Topics | 17 (see below) |

**Topics:** `anxiety` `apple-health` `burnout` `cbt` `claude-code` `claude-skill` `cognitive-behavioral-therapy` `cognitive-distortions` `dbt` `developer-mental-health` `dialectical-behavior-therapy` `hrv` `mental-health` `self-therapy` `stress` `telegram-bot` `thought-record`

---

## 2. Search Rankings

### Query: `CBT Claude Code` (sort: stars)
5 total results. **Our repo appears at #5 (last).**

| # | Repo | Stars | Notes |
|---|---|---|---|
| 1 | Trade-With-Claude/cbt-framework | 10 | "CBT" = Crypto Backtesting — term collision |
| 2 | jondwillis/functional-emotions | 2 | CBT-style reframes for Claude Code hooks |
| 3 | i-am-not-kangjik/cbt-with-claude-code | 0 | Korean CBT website built with Claude Code |
| 4 | LittleSound/adhd-cbt-skill | 1 | ADHD CBT skill for Claude Code |
| **5** | **glebis/claude-cognitive-toolkit** | **0** | **Our repo — last place due to 0 stars** |

### Query: `thought record Claude` (sort: stars)
4 total results. **Our repo appears at #3.**

| # | Repo | Stars | Notes |
|---|---|---|---|
| 1 | arktnld/cbt-llm-kit | 2 | Multi-LLM CBT thought records |
| 2 | pcuenca/thoughts-recorder | 0 | Claude Code session export tool (unrelated) |
| **3** | **glebis/claude-cognitive-toolkit** | **0** | **Our repo** |
| 4 | Felipe-Mulder/daymark | 0 | PHP journal app (unrelated) |

### Query: `DBT skills Claude Code` (sort: stars)
12 total results. **Our repo appears at #10 (last of 10 shown).**

| # | Repo | Stars | Notes |
|---|---|---|---|
| 1 | AltimateAI/data-engineering-skills | 90 | **dbt = data build tool** — major term collision |
| 2 | bonnard-data/bonnard-cli | 46 | Data engineering DBT CLI |
| 3 | kyle-chalmers/dbt-agentic-development | 5 | Data engineering DBT |
| 4 | adityawrk/analytics-with-claude-code | 3 | Data engineering |
| 5 | Snehabankapalli/data-engineering-claude-skills | 1 | Data engineering |
| ... | *(positions 6–9: data engineering repos)* | — | — |
| **10** | **glebis/claude-cognitive-toolkit** | **0** | **Our repo — buried by dbt-core ecosystem** |

> **Critical issue:** "DBT" is dominated by the *data build tool* ecosystem. Searching for Dialectical Behavior Therapy via "DBT" on GitHub is effectively impossible without disambiguation.

### Query: `cognitive-behavioral-therapy claude-skill` (sort: stars)
1 total result. **Our repo is #1 and the only result.**

| # | Repo | Stars | Notes |
|---|---|---|---|
| **1** | **glebis/claude-cognitive-toolkit** | **0** | **Our repo — sole result for this precise query** |

---

## 3. Traffic

Traffic data (views, clones) is not accessible via the GitHub API available in this context. Check via the GitHub web UI under **Insights → Traffic** once the repo has been live for 24+ hours.

---

## 4. README Rendering

The README renders correctly. It is well-structured with:
- Clear title and one-line description
- Section headers for each major feature
- Markdown tables (DBT skills, techniques, pushback levels)
- Code blocks for installation and usage
- Appropriate disclaimer (not a therapist)
- LICENSE and CITATION.cff references

No rendering issues detected.

---

## 5. Comparison vs Reference Repos

| Repo | Stars | Forks | Topics |
|---|---|---|---|
| **glebis/claude-cognitive-toolkit** | **0** | **0** | **17** |
| mukul975/Anthropic-Cybersecurity-Skills | 5,786 | 785 | 20 |
| BayramAnnakov/2026-coach | 30 | 3 | 0 |

The cybersecurity repo is an extreme outlier — it contains 754 skills mapped to 5 frameworks and clearly benefited from viral traction. The coaching repo (30 stars, 0 topics, minimal README) outperforms us purely on age and early sharing.

---

## 6. Findings & Recommendations

### Strengths
- **17 topics** is comprehensive and covers all the right terms for the mental health × Claude Code niche
- **Only repo** matching `cognitive-behavioral-therapy claude-skill` — unique in its specific niche
- **README quality** is high: detailed, technically accurate, honest disclaimer
- **Description** is specific and well-written
- Appears in 3 out of 4 search queries tested within 24 hours of creation

### Issues

**1. "DBT" term collision (high impact)**
The `dbt` topic and "DBT" in the description collide with the data build tool ecosystem, which has hundreds of active repos with thousands of stars. This buries the repo under data engineering content in any "DBT" search. The `dialectical-behavior-therapy` topic helps for topic-browsing, but keyword searches on "DBT" are lost.

*Fix:* In the repo description, replace "DBT" with "Dialectical Behavior Therapy (DBT)" so the description contains the full term. Consider adding a note in the README intro: *"DBT here refers to Dialectical Behavior Therapy, not the data build tool."*

**2. "CBT" term collision (medium impact)**
"CBT" also collides with crypto backtesting (Trade-With-Claude/cbt-framework, 10 stars). Lower impact than DBT but still worth noting.

**3. Zero stars = ranking penalty (high impact)**
GitHub search sorted by stars will always push new repos to the bottom. The repo is 1 day old — this is expected, but traction needs to begin soon to climb.

*Fix:* Share on Reddit (`r/ClaudeAI`, `r/mentalhealth`, `r/productivity`, `r/selfhosted`), Hacker News Show HN, and developer Twitter/Bluesky.

**4. No GitHub Release (medium impact)**
No tagged release reduces trust signals and makes the repo look incomplete.

*Fix:* Tag a `v0.1.0` release with release notes.

**5. Discussions disabled (low impact)**
Enabling GitHub Discussions would let users ask questions and share experiences — this generates organic search-indexed content.

**6. Missing topics (low impact)**
Consider adding: `wellness`, `mindfulness`, `self-help`, `developer-wellness`, `therapy-tools`.

### Priority Action List

1. **Update description** to spell out "Dialectical Behavior Therapy" to defeat dbt-core collision
2. **Tag v0.1.0 release** to add trust signal
3. **Share publicly** — social proof (stars) is the #1 ranking factor
4. **Enable Discussions** for community engagement
5. **Add missing topics**: `wellness`, `mindfulness`, `developer-wellness`
