# 🎯 AI Job Application Command Centre

**Gappy AI Hackathon · June 2026 · Built with Lemma SDK**

> Students applying to 20+ roles across LinkedIn, portals, referrals, and email have no single system that tracks applications, understands their resume against each JD, and actually helps them act. This is that system — and it's agentic, not a spreadsheet.

---

## The Problem (Real, Specific, Mine)

I'm a final-year B.Tech Data Science & AI student at IIT Guwahati. This placement season I'm tracking 20+ Gen AI and ML applications across LinkedIn, company portals, referrals, and cold emails simultaneously.

The current reality:
- Applications scattered across a Notion doc, two spreadsheets, and a WhatsApp thread
- Every JD has to be manually compared against my resume — I'm doing this in my head
- Recruiter messages are rewritten from scratch each time
- Interview prep is a last-minute panic the night before
- I routinely forget to follow up

None of the existing tools solve this. Job boards track applications but don't understand them. ChatGPT gives advice but output lives in a chat thread — there's no state, no structure, no workflow. The work doesn't land anywhere persistent.

**Lemma is exactly the missing piece.**

---

## What I Built

An agentic Job Application Command Centre on Lemma SDK where:

- **Agent input lands as structured rows**, not chat messages
- **Workflows run on real events** (JD pasted → agent runs → columns fill in automatically)
- **Memory is a table**, not a scrollback — every application retains its analysis forever
- **The app is the workspace** — one URL, all your pipeline data + agent drafts together

### Core loop (end-to-end, works now)

1. User adds an application (company, role, source, JD text)
2. Workflow `process_jd` triggers automatically
3. Agent reads the candidate's `resume_context` table (structured profile data)
4. Agent cross-matches JD requirements vs candidate profile
5. Agent writes back to the `applications` table:
   - **Resume Fit Score** (0–10, with justification)
   - **Skill Gaps** (what's in the JD but not in the profile)
   - **Resume Edit Suggestions** (specific bullet rewrites for this role)
   - **Recruiter Message Draft** (~150 words, uses real project names)
   - **Interview Prep Notes** (8–12 questions with answer frameworks)
6. User opens the row → sees everything, copies what they need

### Second workflow: Deep Interview Prep

Triggered on demand from any row. Generates:
- Technical questions by category (ML fundamentals, system design, coding)
- STAR-format behavioural answers using the candidate's actual project experience
- Questions to ask the interviewer (signals seniority)
- 60-second intro script tailored to the company
- Weak-spot analysis + how to address it

### Agent chat strip

Ask the career agent anything:
- "Which role should I focus on this week?"
- "Draft a follow-up email for Sarvam AI — I applied 5 days ago"
- "What skills should I learn for the Krutrim AI role?"

Output is grounded in your actual application data — not generic.

---

## Lemma SDK Primitives Used

| Primitive | How it's used |
|-----------|---------------|
| **Tables** | `applications` (typed schema, row actions, views) and `resume_context` (structured profile/project store that agents read) |
| **Files** | `knowledge/resume_profile.md` and `application_strategy.md` — agent memory that persists across sessions |
| **Agents** | `career_agent` — role-scoped LLM worker with explicit table + file grants; never vague access to everything |
| **Workflows** | `process_jd` (table row action → fetch resume context → agent analysis → write back) and `generate_interview_prep` |
| **Functions** | Deterministic steps inside workflows: fetching and formatting resume context, writing structured results back to table rows |
| **Apps** | Single-file HTML operator UI deployed via `lemma apps deploy` — same pod APIs, no separate backend |

This is not a chatbot with Lemma bolted on. Lemma is the entire infrastructure layer — the agent, its memory, its workspace, and its output format all live in the pod.

---

## Why This Wins

**35% — Problem clarity & real-world fit:** The user is maximally specific — a final-year IIT Guwahati placement student applying to Gen AI roles in India 2026. The workflow (scattered applications → no system → late, generic, unsupported) is real and demoable because I lived it.

**25% — Product judgment:** I didn't build a chatbot. I built a system where agent output lands in a typed table row, persists forever, and powers a purpose-built UI. That's exactly the Lemma thesis — and I understood it before building, not after.

**25% — Execution quality:** Core loop works end-to-end. Paste JD → agent runs → five fields written back to the row. The app shows the pipeline, the scores, the drafts. Zero polish required but the workflow is real.

**15% — SDK utilisation:** Tables, files, agents, workflows, functions, apps — every major Lemma primitive is used meaningfully. The `resume_context` table as an agent knowledge store is a particularly non-obvious use that shows genuine understanding of the pod model.

---

## File Structure

```
career-command-centre/
├── README.md                          ← this file
├── setup.sh                           ← one-shot install + deploy
└── pod/
    ├── pod.yaml                       ← pod manifest
    ├── tables/
    │   ├── applications.yaml          ← application tracker schema + row actions + views
    │   └── resume_context.yaml        ← candidate profile store (agent reads this)
    ├── agents/
    │   └── career_agent.yaml          ← LLM worker: role, tools, permissions, memory
    ├── workflows/
    │   ├── process_jd.yaml            ← core loop: JD → analysis → write back
    │   └── generate_interview_prep.yaml ← deep prep on demand
    ├── files/
    │   ├── resume_profile.md          ← candidate identity, strategy, positioning
    │   └── application_strategy.md    ← tier system, follow-up protocol
    └── apps/
        └── index.html                 ← single-file operator UI (no build)
```

---

## Setup

```bash
# Clone
git clone https://github.com/<your-handle>/career-command-centre
cd career-command-centre

# One-shot setup (installs stack, CLI, imports pod, deploys app)
bash setup.sh

# Or manually:
curl -fsSL https://raw.githubusercontent.com/lemma-work/lemma-platform/main/install.sh | bash
lemma-stack config set LEMMA_DEFAULT_MODEL_TYPE anthropic_compat
lemma-stack config set LEMMA_ANTHROPIC_API_KEY sk-ant-...
lemma-stack restart

uv tool install lemma-terminal
lemma servers select local
lemma auth login
lemma skills install

lemma pod import ./pod
lemma apps deploy career-app ./pod/apps/index.html
```

App runs at `http://127-0-0-1.sslip.io:3711`

### Deploy to lemma.work (live link)

```bash
lemma servers select cloud
lemma auth login
lemma pod import ./pod
lemma apps deploy career-app ./pod/apps/index.html
```

---

## Links

- **GitHub:** https://github.com/[your-handle]/career-command-centre
- **Live (lemma.work):** https://[your-pod].lemma.work/apps/career-app
- **Demo video:** [Loom link]
- **Discord:** https://discord.gg/6dVR7zTvy

---

## Builder

**Ashmita** — B.Tech Data Science & AI, IIT Guwahati (2027)  
IBM GenAI & RAG Certified · International Research Intern, Hanyang University  
Built solo during the Gappy AI Hackathon, June 24–July 1, 2026  
Stack: Lemma SDK · Python · Claude (via Anthropic) · HTML/JS  
Contact: [your email] · [LinkedIn]
