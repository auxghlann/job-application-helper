# STAR Story Bank (Behavioral Interview Source of Truth)

Use this document to store verified, authentic career stories following the STAR framework (Situation, Task, Action, Result). The `interview-helper` agent refers to these stories to prepare tailored interview answers.

---

## Story 1: Handling a Production Regression or Difficult Bug

- **Tags**: Debugging, Incident Response, Problem Solving
- **Company / Project**: Example Tech Inc.
- **Situation**: A critical regression caused user checkout flows to intermittently timeout following a library upgrade.
- **Task**: Identify the root cause within a 2-hour window and deploy a hotfix without downtime.
- **Action**: Instrumented network trace logs with Playwright, traced connection pool exhaustion in database queries, isolated the unindexed join, and pushed an emergency migration adding composite indexes.
- **Result**: Reduced query latency from 3200ms to 45ms, resolved timeouts completely, and authored a post-mortem documenting automated regression tests for similar queries.

---

## Story 2: Cross-Functional Collaboration & Disagreement

- **Tags**: Teamwork, Communication, Product Alignment
- **Company / Project**: Innovate Labs
- **Situation**: Product requested a feature addition 3 days before a scheduled release, risking delivery dates.
- **Task**: Balance product urgency with code quality and release stability.
- **Action**: Met with product lead, mapped out feature complexity, and proposed a phased rollout: ship the critical core functionality for release, then deliver secondary polish in the next sprint.
- **Result**: Feature shipped on schedule without bugs; team adopted phased rollout template for subsequent sprints.

---

## Story 3: Overcoming a Technical Roadblock / Learning a New Tool

- **Tags**: Adaptability, Learning, Technical Growth
- **Company / Project**: ATS Job Application Automation
- **Situation**: Needed to generate pixel-perfect ATS-compliant resumes programmatically without manual graphic design tools.
- **Task**: Build an automated compilation pipeline producing clean PDF outputs from structured data.
- **Action**: Evaluated modern CLI compilers, adopted standalone Tectonic engine with single-column LaTeX templates, and scripted automated builds in PowerShell.
- **Result**: Generated compliant, single-column PDF resumes in under 3 seconds per run, eliminating manual document formatting.
