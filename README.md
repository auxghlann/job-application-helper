# Job Application Helper for Google Antigravity

A specialized autonomous AI agent suite for Google Antigravity that accelerates the job application workflow, eliminates AI hallucinations, and provides grounded interview preparation and mental pacing.

---

## What is Inside?

### Subagent Roster

- **`resume-builder`**: Tailors single-column Typst resumes for target job postings. Submits a 1:1 drafted plan for user review before generating code, compiling directly to ATS-friendly PDF.
- **`cover-letter-builder`**: Drafts authentic, targeted 4-paragraph cover letters with direct problem-solving hooks, free of generic AI buzzwords.
- **`interview-helper`**: Interactive coach that asks targeted questions to surface your real anecdotes and construct personalized STAR answers.
- **`job-posting-crawler`**: Market scout discovering job postings across LinkedIn, JobStreet, Greenhouse, and Lever via targeted search operators.
- **`application-tracker`**: CSV-based pipeline manager computing follow-up dates and pipeline velocity in `data/applications.csv`.
- **`well-being-coach`**: Grounded companion for managing job hunt fatigue, pacing, and ghosting.

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
agy plugin install https://github.com/your-username/job-application-helper
```

Antigravity automatically discovers and activates all skills and agents.

### Option B: Local / Clone Installation

Clone this repository and point Antigravity to it:

1. Clone the repository:
   ```powershell
   git clone https://github.com/your-username/job-application-helper.git
   cd job-application-helper
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

> **Privacy Note**: The `data/` directory and compiled `output/` folders are git-ignored to ensure your personal details, contact info, and applications remain private on your machine.

### 2. Tailor a Resume

Prompt Antigravity with a target job description:
> "Tailor my resume for this role: [paste JD]"

The `resume-builder` agent will match your profile against the JD, present a 1:1 drafted plan for your review and approval, and compile an ATS-compliant PDF into `output/<company>/resume.pdf`.

### 3. Draft a Cover Letter

Prompt Antigravity:
> "Write a cover letter for this job: [paste JD]"

The `cover-letter-builder` agent drafts a direct, 4-paragraph letter and compiles it to `output/<company>/cover-letter.pdf`.

---

## Repository Conventions

- **Strict Zero Emojis**: Code, documentation, templates, and agent outputs avoid emojis across all files.
- **Privacy First**: All candidate profiles, interview anecdotes, and compiled outputs are isolated behind `.gitignore`. Only starter templates and source agents are tracked in version control.
- **Human-in-the-Loop Review Gates**: Generative agents require explicit user approval of drafted content plans before creating or compiling documents.
