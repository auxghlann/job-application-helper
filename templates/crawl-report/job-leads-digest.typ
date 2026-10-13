// Crawled Job Opportunities Digest Template

#set page(
  paper: "a4",
  margin: (x: 1.8cm, top: 1.8cm, bottom: 1.8cm),
)

#set text(
  font: ("Segoe UI", "Arial"),
  size: 9.5pt,
  fill: rgb("#111827"),
  lang: "en",
)

#set par(justify: true, leading: 0.65em)

// Header
#grid(
  columns: (1fr, auto),
  [
    #text(size: 18pt, weight: "bold", fill: rgb("#111827"))[REPORT_TITLE_PLACEHOLDER] \
    #v(2pt)
    #text(size: 10pt, fill: rgb("#4b5563"))[Market Intelligence & Verified Openings Digest]
  ],
  [
    #align(right)[
      #text(size: 8.5pt, fill: rgb("#6b7280"))[Generated: DATE_PLACEHOLDER] \
      #text(size: 8.5pt, fill: rgb("#6b7280"))[Target Roles: TARGET_ROLES_PLACEHOLDER]
    ]
  ]
)

#v(6pt)
#line(length: 100%, stroke: 0.8pt + rgb("#d1d5db"))
#v(10pt)

// Summary Statistics
#rect(
  width: 100%,
  fill: rgb("#f9fafb"),
  stroke: 0.5pt + rgb("#e5e7eb"),
  radius: 4pt,
  inset: 10pt,
)[
  #grid(
    columns: (1fr, 1fr, 1fr),
    [
      #text(weight: "bold", fill: rgb("#374151"))[Total Leads Found:] \
      #text(size: 13pt, weight: "bold", fill: rgb("#111827"))[TOTAL_COUNT_PLACEHOLDER]
    ],
    [
      #text(weight: "bold", fill: rgb("#374151"))[High Fit (>= 80%):] \
      #text(size: 13pt, weight: "bold", fill: rgb("#15803d"))[HIGH_FIT_COUNT_PLACEHOLDER]
    ],
    [
      #text(weight: "bold", fill: rgb("#374151"))[Stretch Fit:] \
      #text(size: 13pt, weight: "bold", fill: rgb("#b45309"))[STRETCH_COUNT_PLACEHOLDER]
    ]
  )
]

#v(12pt)

// Section: Discovered Opportunities
#text(size: 12pt, weight: "bold", fill: rgb("#1f2937"))[Discovered Opportunities]
#v(2pt)
#line(length: 100%, stroke: 0.5pt + rgb("#e5e7eb"))
#v(8pt)

JOB_CARDS_PLACEHOLDER

#v(16pt)
#line(length: 100%, stroke: 0.5pt + rgb("#e5e7eb"))
#v(4pt)
#align(center)[
  #text(size: 8pt, fill: rgb("#9ca3af"))[
    Generated via job-posting-crawler | Exported with typst-pdf
  ]
]
