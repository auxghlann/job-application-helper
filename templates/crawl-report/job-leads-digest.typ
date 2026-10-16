// Crawled Job Opportunities Digest Template
// Zero emojis, ATS-compliant styling, rubric scoring and verification badge

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

#let job_card(
  title: "",
  company: "",
  location: "",
  arrangement: "",
  posted_date: "",
  salary: "Not disclosed",
  score: 0,
  score_breakdown: "",
  requirements: (),
  evidence: "",
  gaps: "",
  apply_url: "",
  verification_status: "Verified Active",
) = {
  rect(
    width: 100%,
    stroke: 0.5pt + rgb("#e5e7eb"),
    radius: 4pt,
    inset: 10pt,
    fill: rgb("#ffffff"),
  )[
    #grid(
      columns: (1fr, auto),
      [
        #text(size: 11.5pt, weight: "bold", fill: rgb("#111827"))[#title] \
        #text(size: 10pt, weight: "medium", fill: rgb("#374151"))[#company]
      ],
      [
        #align(right)[
          #rect(
            fill: if score >= 80 { rgb("#dcfce7") } else if score >= 65 { rgb("#fef3c7") } else { rgb("#fee2e2") },
            radius: 3pt,
            inset: (x: 6pt, y: 3pt),
            stroke: 0.5pt + if score >= 80 { rgb("#86efac") } else if score >= 65 { rgb("#fde68a") } else { rgb("#fca5a5") }
          )[
            #text(
              size: 8.5pt,
              weight: "bold",
              fill: if score >= 80 { rgb("#15803d") } else if score >= 65 { rgb("#b45309") } else { rgb("#b91c1c") }
            )[Score: #str(score)/100]
          ]
        ]
      ]
    )
    
    #v(4pt)
    #text(size: 8.5pt, fill: rgb("#4b5563"))[
      *Location & Arrangement:* #location (#arrangement) | *Compensation:* #salary \
      *Posted:* #posted_date | *Status:* #text(fill: rgb("#15803d"), weight: "bold")[#verification_status]
    ]
    
    #v(4pt)
    #line(length: 100%, stroke: 0.4pt + rgb("#f3f4f6"))
    #v(3pt)
    
    #text(size: 8.5pt, fill: rgb("#374151"))[
      *Rubric Breakdown:* #score_breakdown \
      *Evidence:* #evidence \
      *Gaps:* #if gaps == "" { "None identified" } else { gaps }
    ]
    
    #if requirements.len() > 0 [
      #v(3pt)
      #text(size: 8.5pt, weight: "bold", fill: rgb("#374151"))[Key Requirements:]
      #list(..requirements.map(r => text(size: 8.5pt, fill: rgb("#4b5563"))[#r]))
    ]
    
    #v(4pt)
    #align(right)[
      #link(apply_url)[#text(size: 9pt, weight: "bold", fill: rgb("#2563eb"))[Apply Directly]]
    ]
  ]
}

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
    columns: (1fr, 1fr, 1fr, 1fr),
    [
      #text(weight: "bold", fill: rgb("#374151"))[Total Leads Found:] \
      #text(size: 13pt, weight: "bold", fill: rgb("#111827"))[TOTAL_COUNT_PLACEHOLDER]
    ],
    [
      #text(weight: "bold", fill: rgb("#374151"))[Primary Location Match:] \
      #text(size: 13pt, weight: "bold", fill: rgb("#1d4ed8"))[LOCAL_COUNT_PLACEHOLDER]
    ],
    [
      #text(weight: "bold", fill: rgb("#374151"))[High Fit (>= 80 pts):] \
      #text(size: 13pt, weight: "bold", fill: rgb("#15803d"))[HIGH_FIT_COUNT_PLACEHOLDER]
    ],
    [
      #text(weight: "bold", fill: rgb("#374151"))[Freshness Filter:] \
      #text(size: 13pt, weight: "bold", fill: rgb("#047857"))[<= 3 Days]
    ]
  )
]

#v(12pt)

// Section: Discovered Opportunities
#text(size: 12pt, weight: "bold", fill: rgb("#1f2937"))[Discovered Opportunities (Priority Ordered by Profile Fit)]
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
