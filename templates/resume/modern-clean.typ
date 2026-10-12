// Modern Clean ATS-Optimized Resume Template
// Single-column layout for high ATS parser fidelity

#set page(
  paper: "a4",
  margin: (x: 1.5cm, top: 1.5cm, bottom: 1.5cm),
)

#set text(
  font: ("Segoe UI", "Arial"),
  size: 10pt,
  fill: rgb("#111827"),
  lang: "en",
)

#set par(justify: false, leading: 0.55em)

// Styles
#let section-title(title) = {
  v(8pt)
  text(weight: "bold", size: 11pt, upper(title))
  v(-3pt)
  line(length: 100%, stroke: 0.6pt + rgb("#d1d5db"))
  v(2pt)
}

#let exp-entry(title: "", company: "", location: "", date: "", bullets: ()) = {
  block(width: 100%, breakable: false)[
    #grid(
      columns: (1fr, auto),
      text(weight: "bold")[#title] + text(fill: rgb("#4b5563"))[ --- #company],
      text(fill: rgb("#4b5563"), size: 9pt)[#date],
    )
    #if location != "" [
      #v(-2pt)
      #text(size: 8.5pt, fill: rgb("#6b7280"), style: "italic")[#location]
    ]
    #v(1pt)
    #list(
      marker: [•],
      spacing: 5pt,
      ..bullets
    )
    #v(3pt)
  ]
}

#let project-entry(name: "", url: "", date: "", bullets: ()) = {
  block(width: 100%, breakable: false)[
    #grid(
      columns: (1fr, auto),
      [
        #text(weight: "bold")[#name]
        #if url != "" [
          #text(size: 8.5pt)[ (#link(url)[#url])]
        ]
      ],
      text(fill: rgb("#4b5563"), size: 9pt)[#date],
    )
    #v(1pt)
    #list(
      marker: [•],
      spacing: 5pt,
      ..bullets
    )
    #v(3pt)
  ]
}

// Header
#align(center)[
  #text(size: 20pt, weight: "bold")[NAME_PLACEHOLDER] \
  #v(2pt)
  #text(size: 11pt, weight: "medium", fill: rgb("#374151"))[TITLE_PLACEHOLDER] \
  #v(3pt)
  #text(size: 9pt, fill: rgb("#4b5563"))[
    LOCATION_PLACEHOLDER | 
    #link("mailto:EMAIL_PLACEHOLDER") | 
    PHONE_PLACEHOLDER | 
    #link("LINKEDIN_URL_PLACEHOLDER")[LinkedIn] | 
    #link("GITHUB_URL_PLACEHOLDER")[GitHub]
  ]
]

// Professional Summary
#section-title("Professional Summary")
SUMMARY_PLACEHOLDER

// Technical Skills
#section-title("Technical Skills")
#grid(
  columns: (auto, 1fr),
  column-gutter: 8pt,
  row-gutter: 4pt,
  [*Languages:*], [LANGUAGES_PLACEHOLDER],
  [*Frameworks & Libraries:*], [FRAMEWORKS_PLACEHOLDER],
  [*Tools & Platforms:*], [TOOLS_PLACEHOLDER],
  [*Core Methodologies:*], [METHODOLOGIES_PLACEHOLDER],
)

// Professional Experience
#section-title("Professional Experience")
EXPERIENCE_BLOCK_PLACEHOLDER

// Key Projects
#section-title("Key Projects")
PROJECTS_BLOCK_PLACEHOLDER

// Education
#section-title("Education")
EDUCATION_BLOCK_PLACEHOLDER
