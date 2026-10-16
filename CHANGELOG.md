# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [v1.0.0] - 2026-10-16

### Features
- Rebranded suite to Pick Me (repository `auxghlann/pick-me`) with direct user document exports.
- Converted generative, tracking, and coaching agents (`resume-builder`, `cover-letter-builder`, `application-tracker`, `interview-helper`, `well-being-coach`) to lean inline skills, eliminating N x M context duplication.
- Isolated `job-posting-crawler` as the dedicated scout subagent with Playwright MCP support and sandboxed execution.
- Calibrated 100-point crawler rubric to prioritize Years of Experience & Seniority Calibration (40 pts) over Skills (25 pts), including a +1 yr slight stretch, -15 pt heavy penalty for +2 yr deficits, and hard exclusion for >= 3 yr experience deficits.
- Relocated all generated application artifacts and crawl digests to `~/Documents/pick-me-output/`.
- Integrated `typst-pdf` generic compiler utility for ATS-compliant single-column resumes, cover letters, and crawl report PDFs.
