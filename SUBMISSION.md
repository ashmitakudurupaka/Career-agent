# Hackathon Submission — Gappy AI · July 1, 2026

## Problem Statement
AI Job Application Command Centre (CAREER track)

---

## Problem I Solved

Students and recent graduates applying to AI/ML roles face a coordination collapse: applications scattered across portals, referrals, and emails; no single system that understands their resume against each JD; recruiter messages rewritten from scratch every time; interview prep a last-minute panic.

The specific user: a final-year IIT Guwahati Data Science student (me) applying to 20+ Gen AI and ML roles this placement season across LinkedIn, company portals, cold email, and referrals simultaneously.

Current tools fail because they're either passive (spreadsheets that record but don't act) or stateless (ChatGPT that gives advice but whose output evaporates in a chat scrollback). There is no system where the agent's work lands persistently and the candidate can act on it.

---

## My Solution

An agentic Job Application Command Centre on Lemma SDK.

**Core loop:**
1. User pastes a job description into a new application row
2. Lemma workflow `process_jd` triggers automatically
3. `career_agent` reads the candidate's `resume_context` table (structured profile data: projects, skills, certifications)
4. Agent cross-matches JD requirements against the profile
5. Agent writes five structured outputs back to the `applications` table row:
   - Resume Fit Score (0–10)
   - Skill Gaps (what's in JD but missing from profile)
   - Resume Edit Suggestions (specific bullet rewrites for this role)
   - Recruiter Message Draft (~150 words, uses real project names)
   - Interview Prep Notes (8–12 questions + answer frameworks)
6. User sees everything in the operator app — copies what they need, acts immediately

**Second workflow:** `generate_interview_prep` — triggered on demand, generates a full prep document: technical questions by category, STAR behavioural answers using real projects, questions to ask the interviewer, a 60-second intro script, and a weak-spot analysis.

**Agent chat strip:** Ask the career agent free-form questions grounded in your actual pipeline data.

---

## Lemma SDK Components Used

- **Tables:** `applications` (typed schema, row actions, filtered views) + `resume_context` (candidate profile store — the agent's knowledge base)
- **Files:** `knowledge/resume_profile.md` + `application_strategy.md` — persistent agent memory across sessions
- **Agents:** `career_agent` — role-scoped, table-granted, file-granted LLM worker
- **Workflows:** `process_jd` (row action → fetch context → agent → write back) + `generate_interview_prep`
- **Functions:** Deterministic steps within workflows (context formatting, record updates)
- **Apps:** Single-file HTML operator UI deployed via `lemma apps deploy`

---

## Demo

[Loom screen recording link — shows: add application → paste JD → agent runs → five columns fill in automatically → open row → read recruiter draft → copy to LinkedIn]

---

## Live Product

https://[your-pod].lemma.work/apps/career-app

---

## GitHub

https://github.com/[your-handle]/career-command-centre

---

## Builder

Ashmita · B.Tech Data Science & AI · IIT Guwahati (2027) · Solo build
