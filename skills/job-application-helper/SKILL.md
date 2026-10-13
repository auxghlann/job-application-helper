---
name: job-application-helper
description: Comprehensive guide, onboarding instructions, and runbooks for the job-application-helper domain. Use when the user asks how to apply for jobs, tailor resumes, write cover letters, prepare for interviews, crawl job boards, track applications in applications.csv, or manage job search burnout and well-being.
---

# Job Application Helper Guide & Runbooks

## Overview
The `job-application-helper` domain provides an end-to-end, human-grounded job application acceleration platform. It is engineered around a strict **Anti-Hallucination Constitution**: every resume bullet, cover letter claim, and interview story must strictly map to verified candidate facts documented in `data/candidate-profile.yaml` and `data/star-stories.md`.

---

## 1. Onboarding Checklist (First-Time Setup)

Before running application generation tasks, ensure the following three prerequisites are satisfied:

### Step 1: Initialize the Candidate Profile (Interactive or Manual)
The candidate profile is the single source of truth for all generative subagents.
- **Recommended**: Run the `get-to-know-me` skill to either import an existing resume (PDF/DOCX/Markdown) or complete a guided conversational interview.
- **Manual Setup**: If configuring manually, run `init-profile.ps1` and edit `data/candidate-profile.yaml`:
  ```powershell
  powershell -ExecutionPolicy Bypass -File "job-application-helper/scripts/init-profile.ps1"
  ```
  Fill in contact info, target preferences, skills matrix, experience highlights, and projects.

### Step 2: Seed the STAR Story Bank
- Open `data/star-stories.md`.
- Record 2-3 genuine career anecdotes following the Situation, Task, Action, Result framework (e.g. overcoming a major technical bug, navigating team conflict, delivering an ambiguous project).

### Step 3: Verify Typst PDF Compilation Tooling
Resumes and cover letters are authored in Typst and compiled directly to PDF.
- Recommended compiler: **Typst** (zero-config, lightweight CLI engine).
- To install via Windows Package Manager:
  ```powershell
  winget install -e --id Typst.Typst
  ```
- Test compilation with:
  ```powershell
  powershell -ExecutionPolicy Bypass -File "job-application-helper/scripts/compile-typst.ps1" -TypstFile "job-application-helper/templates/resume/modern-clean.typ" -OutputFile "job-application-helper/output/test/resume.pdf"
  ```

---

## 2. Subagent Roster & Dispatch Guide

When executing job application tasks, delegate to the appropriate specialized subagent:

| Subagent | Role | Trigger / Use Case | Key Files |
| :--- | :--- | :--- | :--- |
| `job-posting-crawler` | Market Scout | Discovering and evaluating job openings via Google dorks | `agents/job-posting-crawler.md` |
| `resume-builder` | Typst Resume Tailor | Tailoring an ATS single-column resume to a target JD and compiling to PDF | `templates/resume/modern-clean.typ`, `data/candidate-profile.yaml` |
| `cover-letter-builder` | Authentic Writer | Drafting a non-generic 4-paragraph cover letter grounded in profile facts | `templates/cover-letter/clean-letter.typ`, `data/candidate-profile.yaml` |
| `application-tracker` | Pipeline Manager | Logging applications into `applications.csv` and scheduling follow-up alerts | `data/applications.csv` |
| `interview-helper` | Interview Coach | Interactive prep, extracting anecdotes, and generating 1:1 STAR responses | `data/star-stories.md` |
| `well-being-coach` | Mental Companion | Burnout support, rejection fatigue, daily pacing, and pre-interview calming | `agents/well-being-coach.md` |

---

## 3. Standard Operational Runbooks

### Runbook A: Finding Target Opportunities
1. Identify candidate preferences in `data/candidate-profile.yaml`.
2. Dispatch `job-posting-crawler` to run Google dork queries via `search_web`:
   - `"software engineer" site:boards.greenhouse.io "remote"`
   - `"frontend developer" site:jobs.lever.co "remote"`
   - `"full stack" site:jobs.ashbyhq.com "remote"`
3. Parse job descriptions and score technical alignment against the candidate profile.
4. Present top 3-5 high-fit listings with direct application URLs.

### Runbook B: Tailoring Resume & Compiling PDF
1. Ingest target job description text.
2. Dispatch `resume-builder`:
   - Inspect both `data/candidate-profile.yaml` and `data/star-stories.md`.
   - Match candidate skills and verified experience against JD keywords.
   - Strictly forbid fabricating unverified skills, employers, or inflated metrics. Flag any missing skills honestly.
   - **Mandatory Review Plan Gate**: Author an implementation plan artifact containing the complete 1:1 drafted content (verbatim summary, skills, experience bullets, and projects) and request user feedback (`RequestFeedback: true`).
   - Halt execution until the user reviews and approves the plan.
   - Once approved, populate `templates/resume/modern-clean.typ` and save to `output/<company_name>/resume_<company_name>.typ`.
   - Delegate compilation to the `typst-pdf` skill to produce `output/<company_name>/resume_<company_name>.pdf`.
3. Prompt candidate: *"Did you submit your application to [Company] for [Role]?"*
   - If yes, invoke `application-tracker` to log record in `data/applications.csv`.

### Runbook C: Authoring Authentic Cover Letters
1. Ingest target job description text and company mission.
2. Dispatch `cover-letter-builder`:
   - Ground the letter strictly in `data/candidate-profile.yaml` and `data/star-stories.md`.
   - Draft a compressed 3-4 paragraph letter (under 280 words total: Hook -> Core Engineering Match -> Alignment & Forward Close).
   - Strictly ban AI clichés (*"I am writing to express my enthusiasm..."*) and hype buzzwords (*"spearhead"*, *"leverage"*, *"cutting-edge"*, *"robust"*).
   - Ensure text uses full justification (`#set par(justify: true)`).
   - **Mandatory Review Plan Gate**: Author an implementation plan artifact containing the complete 1:1 drafted cover letter text verbatim and request user feedback (`RequestFeedback: true`).
   - Halt execution until the user reviews and approves the letter.
   - Once approved, populate `templates/cover-letter/clean-letter.typ` and save to `output/<company_name>/cover_letter_<company_name>.typ`.
   - Delegate compilation to the `typst-pdf` skill to produce `output/<company_name>/cover_letter_<company_name>.pdf`.

### Runbook D: Pipeline Tracking (`applications.csv`)
1. All applications are tracked in `data/applications.csv` (RFC 4180 CSV compliant).
2. Lifecycle statuses:
   - `Drafted` -> `Applied` -> `Screening` -> `Interviewing` -> `Offer` / `Rejected` / `Ghosted`.
3. Standard operations via `application-tracker`:
   - Append new application with automatically calculated `Follow_Up_Date` (+7 days).
   - Update statuses when candidate receives emails or recruiter calls.
   - Compute weekly submission velocity metrics.

### Runbook E: Interactive Interview Coaching
1. Ingest upcoming interview context (Company, Round Type, Interviewer Roles).
2. Dispatch `interview-helper`:
   - Inspect `data/star-stories.md`.
   - Interactively interview the candidate to pull out real, unscripted anecdotes.
   - Shape stories into crisp STAR talking points (Situation, Task, Action, Result).
   - Formulate 4-5 high-signal reverse interview questions to ask the hiring team.
   - Save newly discovered stories to `data/star-stories.md`.

### Runbook F: Daily Pacing & Mental Well-being
1. Job searching while unemployed requires psychological endurance and strict boundaries.
2. Dispatch `well-being-coach`:
   - Enforce sustainable application quotas: 2-3 tailored applications per day over mass spamming.
   - De-personalize rejections: process ATS automated rejections without invalidating candidate effort.
   - Lead pre-interview grounding and anxiety reduction exercises.
   - Celebrate small, controllable daily wins (materials polished, applications submitted).

---

## 4. Directory & File Reference

```text
job-application-helper/
├── templates/
│   ├── candidate-profile.template.yaml # Clean candidate schema template
│   ├── star-stories.template.md        # STAR story starter template
│   ├── applications.template.csv       # Pipeline tracker starter template
│   ├── resume/modern-clean.typ         # Single-column ATS Typst resume template
│   ├── cover-letter/clean-letter.typ   # Clean matching Typst cover letter template
│   └── crawl-report/job-leads-digest.typ # Crawled job openings digest template
├── skills/
│   ├── typst-pdf/                      # Generic Typst compilation & PDF export skill
│   │   ├── SKILL.md
│   │   └── scripts/compile.ps1
│   ├── get-to-know-me/SKILL.md         # Candidate onboarding interview & import
│   └── job-application-helper/SKILL.md # Domain guide & dispatch runbooks
├── data/                               # Private candidate data (git-ignored)
│   ├── candidate-profile.yaml          # Master profile (single source of truth)
│   ├── star-stories.md                 # Behavioral interview anecdotes (STAR)
│   └── applications.csv                # Central pipeline tracker
├── scripts/
│   ├── compile-typst.ps1               # Typst compiler wrapper
│   └── init-profile.ps1                # Profile initialization helper (copies from templates/)
├── agents/                             # Subagent prompt specifications
└── rules/AGENTS.md                     # Domain directives and prompt contracts
```

---

## 5. Strict Domain Laws

1. **Anti-Hallucination Mandate**: Never invent facts, past employers, degrees, metrics, or technologies not present in `candidate-profile.yaml`.
2. **Strict Zero Emojis**: Strictly zero emojis across all code, documents, LaTeX files, templates, and messages.
3. **Pacing Over Panic**: Encourage deliberate, high-quality applications over demoralizing spray-and-pray blasts.
