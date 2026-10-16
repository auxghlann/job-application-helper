---
name: typst-pdf
description: Generic markup assembly and PDF compilation utility using the Typst CLI. Handles document geometry, full justification, typography standards, and error-free PDF compilation for any arbitrary document. Zero domain or business logic.
---

# Typst PDF Compilation & Assembly Skill (`typst-pdf`)

## Purpose
A pure, reusable utility skill for creating, assembling, and compiling documents into PDFs using the [Typst](https://typst.app/) engine. Contains **zero business logic** (no resume, cover letter, or job tracking rules). Any subagent requiring PDF output can invoke this skill to validate syntax and execute compilation.

---

## Tooling & Prerequisites

Typst is a fast, lightweight modern CLI markup compiler.

### Verifying or Installing Typst CLI
- To verify installation: `typst --version`
- If missing, prompt user confirmation before installing via Windows Package Manager:
  ```powershell
  winget install -e --id Typst.Typst
  ```

---

## Executing Compilation

To compile any `.typ` source file to PDF, use the bundled compilation script:

```powershell
powershell -ExecutionPolicy Bypass -File "skills/typst-pdf/scripts/compile.ps1" -TypstFile "<path/to/source.typ>" -OutputFile "<path/to/target.pdf>"
```

- If `-OutputFile` is omitted, the script automatically writes `<source_basename>.pdf` alongside the source file.
- The script automatically ensures target directories exist before writing.

---

## Core Typst Markup Standards & Syntax Pitfalls

When authoring or modifying `.typ` markup for compilation, adhere strictly to these rules:

### 1. Document Geometry & Setup
```typst
#set page(
  paper: "a4",
  margin: (x: 1.8cm, top: 1.8cm, bottom: 1.8cm),
)
```

### 2. Typography & Fonts
Always use universally available fonts on Windows/Linux with fallbacks to avoid warnings or font substitution errors:
```typst
#set text(
  font: ("Segoe UI", "Arial"),
  size: 10pt,
  fill: rgb("#111827"),
  lang: "en",
)
```

### 3. Paragraph Justification & Leading
To prevent ragged right margins and ensure crisp, aligned documents:
```typst
#set par(justify: true, leading: 0.65em)
```

### 4. Escaping Links & Emails (Crucial)
In Typst markup mode, `@identifier` is parsed as a bibliography or label reference. Using raw `@` in unescaped text (e.g. `john@example.com`) causes label resolution crashes. Always wrap links and emails explicitly:
- For emails: `#link("mailto:name@example.com")[name@example.com]` or `#text("name@example.com")`
- For URLs: `#link("https://example.com")[example.com]`

### 5. Structure & Layout Primitives
- Spacing: `#v(8pt)` for vertical space, `#h(6pt)` for horizontal space.
- Dividers: `#line(length: 100%, stroke: 0.5pt + rgb("#e5e7eb"))`
- Two-column or key-value layouts: Use `#grid(columns: (1fr, auto), ...)`
- Section headers:
  ```typst
  #text(size: 12pt, weight: "bold", fill: rgb("#1f2937"))[Section Title]
  #v(2pt)
  #line(length: 100%, stroke: 0.5pt + rgb("#d1d5db"))
  #v(4pt)
  ```

---

## Checklist Before Invoking Compiler
1. Target directories exist or are handled by `compile.ps1`.
2. All raw emails and URLs are wrapped in `#link(...)` or `#text(...)`.
3. `#set par(justify: true)` is declared if block justification is required.
4. Output file follows `.pdf` extension.
