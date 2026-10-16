# Pick Me!: Job Application Assistant for Google Antigravity

A specialized autonomous career acceleration suite for Google Antigravity that eliminates AI hallucinations, tailors ATS resumes and authentic cover letters, conducts human-in-the-loop interview coaching, and saves all outputs directly to your personal Documents folder.

---

## What is Inside?

### Architecture: Subagent + Modular Skills

This suite employs a lean architectural split to maximize speed and token efficiency without context loss:

#### Dedicated Subagent (Isolated Sandbox)
- **`job-posting-crawler`**: Market scout discovering and live-verifying job postings across regional portals and ATS boards (Greenhouse, Lever, Ashby, JobStreet, Kalibrr). Evaluates postings via a 100-point rubric prioritizing Years of Experience over skills with heavy penalties and exclusions for experience deficits. Isolated in a subagent to keep transient web search and DOM scraping tokens out of your main session.

#### Inline Modular Skills (Zero Subagent Overhead & In-Memory Continuity)
- **`resume-builder`**: Tailors single-column Typst resumes for target job postings. Submits a 1:1 drafted plan for user review before generating code, compiling directly to ATS-friendly PDF.
- **`cover-letter-builder`**: Drafts authentic, targeted 3-4 paragraph cover letters with direct problem-solving hooks, free of generic AI buzzwords.
- **`interview-helper`**: Interactive coach that asks targeted questions to surface your real anecdotes and construct personalized STAR answers.
- **`application-tracker`**: CSV-based pipeline manager computing follow-up dates and pipeline velocity in `data/applications.csv`.
- **`well-being-coach`**: Grounded companion for managing job hunt fatigue, pacing (2-3 tailored apps/day), and ghosting.
- **`get-to-know-me`**: Candidate onboarding skill that extracts authentic career facts and STAR stories from an existing resume or guided chat.
- **`typst-pdf`**: Generic Typst markup assembly and compilation utility.

---

## Prerequisites

- [Google Antigravity CLI](https://github.com/google-deepmind) installed and configured on your system.
- PowerShell 7+ or Windows PowerShell.
- [Typst](https://typst.app/) installed on your PATH (required for PDF compilation):
  ```powershell
  winget install --id Typst.Typst
  ```

---

## Installation

### Option A: Install via Antigravity CLI (Recommended)

Install the plugin directly from GitHub into your Antigravity environment:

```powershell
agy plugin install https://github.com/auxghlann/pick-me
```

Antigravity automatically discovers and activates all skills and agents.

### Option B: Local / Clone Installation

Clone this repository and point Antigravity to it:

1. Clone the repository:
   ```powershell
   git clone https://github.com/auxghlann/pick-me.git
   cd pick-me
   ```
2. Install as a local plugin:
   ```powershell
   agy plugin install .
   ```

---

## Quickstart Guide

### 1. Set Up Your Candidate Profile (Source of Truth)

All generative actions are strictly grounded in your verified facts to prevent hallucinations.

1. Initialize your profile from the included templates:
   ```powershell
   .\scripts\init-profile.ps1
   ```
   This creates:
   - `data/candidate-profile.yaml`: Your master work history, skills, and projects.
   - `data/star-stories.md`: Your verified behavioral interview anecdotes.
   - `data/applications.csv`: Your pipeline tracking sheet.
2. Or use the onboarding skill: tell Antigravity, *"Run get-to-know-me to import my resume"*, and provide your current resume to populate your profile automatically.

> **Privacy Note**: Candidate files in `data/` are git-ignored. All generated resumes, cover letters, and crawl reports are saved directly to your local user directory (`~/Documents/pick-me-output/`), keeping the codebase clean and your documents easily accessible in Windows Explorer.

### 2. Tailor a Resume

Prompt Antigravity with a target job description:
> "Tailor my resume for this role: [paste JD]"

The `resume-builder` skill will match your profile against the JD, present a 1:1 drafted plan for your review and approval, and compile an ATS-compliant PDF into `~/Documents/pick-me-output/applications/<app_id>_<company>/resume_<company>.pdf`.

### 3. Draft a Cover Letter

Prompt Antigravity:
> "Write a cover letter for this job: [paste JD]"

The `cover-letter-builder` skill drafts a direct, 4-paragraph letter and compiles it to `~/Documents/pick-me-output/applications/<app_id>_<company>/cover_letter_<company>.pdf`.

---
