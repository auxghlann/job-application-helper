---
name: application-tracker
description: Maintains job application records in data/applications.csv, tracks application statuses, schedules follow-ups, and computes pipeline metrics.
---

# Skill: application-tracker

## Overview
This skill manages the job search pipeline recorded in `data/applications.csv`. It handles sequential ID reservation, logging submissions, transitioning lifecycle statuses, scheduling 7-14 day follow-ups, and calculating pipeline metrics.

---

## Data Architecture (`data/applications.csv`)
Standard RFC 4180 CSV compliance is strictly required.

### Schema Fields
1. `ID`: Unique identifier (e.g. `APP-001`, `APP-002`).
2. `Date_Applied`: ISO date string (`YYYY-MM-DD`).
3. `Company`: Legal or brand name of employer.
4. `Role`: Exact title of position.
5. `Location`: Job location (e.g., `Remote`, `Manila, Philippines`).
6. `Work_Type`: `Remote`, `Hybrid`, or `Onsite`.
7. `Status`: Valid lifecycle states:
   - `Drafted`: Materials prepared but application not yet submitted.
   - `Applied`: Application officially submitted.
   - `Screening`: Recruiter or HR screening scheduled / in progress.
   - `Interviewing`: Technical, take-home, or behavioral rounds active.
   - `Offer`: Formal or verbal employment offer extended.
   - `Rejected`: Formal rejection received.
   - `Ghosted`: 21+ days without response after submission or interview.
8. `Salary_Range`: Compensation range (if disclosed).
9. `Source`: Origin platform or channel (e.g., `JobStreet`, `LinkedIn`, `Company Portal`, `Kalibrr`, `Referral`).
10. `Job_URL`: Link to posting or ATS application portal.
11. `Resume_Path`: Path to tailored resume PDF (`~/Documents/pick-me-output/applications/<app_id>_<company>/resume_<company>.pdf`).
12. `Cover_Letter_Path`: Path to tailored cover letter PDF (`~/Documents/pick-me-output/applications/<app_id>_<company>/cover_letter_<company>.pdf`).
13. `Follow_Up_Date`: Target date for follow-up message (+7 to +14 days from `Date_Applied`).

---

## Core Operations

### 1. Reserve Next Application ID
- Read `data/applications.csv`.
- Inspect existing IDs to find the highest sequential integer (e.g., `APP-012` -> next is `APP-013`).

### 2. Log New Application
- Append a new RFC 4180 compliant CSV line with:
  - `ID`: Reserved identifier.
  - `Date_Applied`: Current date (`YYYY-MM-DD`).
  - `Company`, `Role`, `Location`, `Work_Type`.
  - `Status`: `Applied` (or `Drafted` if pending submission).
  - `Salary_Range`, `Source`, `Job_URL`.
  - `Resume_Path`, `Cover_Letter_Path`.
  - `Follow_Up_Date`: Automatically set to +7 days from `Date_Applied`.

### 3. Update Lifecycle Status
- Find target row by `ID` or `Company` + `Role`.
- Transition status (e.g., `Applied` -> `Screening` -> `Interviewing`).
- Never delete historical records; transition inactive records to `Rejected` or `Ghosted` to preserve pipeline velocity metrics.

### 4. Compute Pipeline Health Metrics
Scan `data/applications.csv` and report:
- Total Applications Submitted (`Status != Drafted`).
- Active in Pipeline (`Screening` + `Interviewing`).
- Pending Follow-Ups (`Follow_Up_Date <= today` and `Status == Applied`).
- Weekly Submission Velocity.

---

## Strict Constraints
- Always preserve CSV quoting and header integrity.
- Strictly zero emojis in CSV data and messages.

