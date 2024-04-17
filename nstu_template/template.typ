// NSTU report template by Begichev Alexander (https://github.com/Breadp4ck)
// with help from Tombleron (https://github.com/Tombleron)  show image: it => {

#let project(
  faculty: none, // ФПМИ, АВТф
  students: (),
  teachers: (),
  department: none,
  discipline: none,
  task_type: none,
  task_name: none,
  variant: none,
  group: none,
  team: none,
  year: none,
  show_title_page: true,
  body,
) = {
  // Set the document's basic properties.
  set document(author: students, title: task_name)
  set text(font: ("Raleway", "Fira Code"), lang: "ru", weight: "regular")

  if show_title_page { page(
    background: image("images/border.png", width: 90%),
    align(center + horizon)[
   
    #set text(size:14pt, font: ("Raleway"))

    // Information about work
    #align(center + top)[
      #image("images/eagle.png", width: 20%)
  
      #v(3em, weak: true)
      
      Федеральное государственное бюджетное \
      образовательное учреждение высшего образования \
      #smallcaps(["Новосибирский государственный технический университет"]) \
  
      #v(3em, weak: true)

      #if {faculty == "ФПМИ"} [#image("images/logo_fami.png")]
      #if {faculty == "АВТФ"} [#image("images/logo_avtf.png")]
  
      #v(3em, weak: true)
      
      #department
  
      #v(1.5em, weak: true)
  
      #if {task_type != none} [
        #task_type \
        #if {discipline != none } [ по дисциплине "#discipline" ]
      ] else if {discipline != none } [
        Дисциплина "#discipline"
      ]
  
      #v(1.5em, weak: true)
  
      #if {task_name != none} [ #text(weight: "semibold", smallcaps(task_name)) ]
    ]

    // Information about students
    #grid(
      columns: (5cm, 1fr),
      align(left + top)[
        #if {group != none} [ Группа: #group \ ]
        #if {team != none} [ Бригада: #team \ ]
        #if {variant != none} [ Вариант: #variant \ ]
      ],
      align(left + top)[
        #for student in students [ #upper(student) \ ]
      ],
    )

    // Information about teachers
    #grid(
      columns: (5cm, 1fr),
      align(left + top)[
        #if {teachers.len() != 0} [ Преподаватели: \ ]
      ],
      align(left + top)[
        #for teacher in teachers [#upper(teacher)]
      ],
    )
    
    #align(center + bottom)[
      #if {year != none} [Новосибирск, #year] else [Новосибирск]
    ]
  ])}
  
  // = Main body config
  
  set page(numbering: "1", number-align: center)
  set heading(numbering: "1.")
  show heading: set block(above: 1em, below: 1em)

  // = Paragraph config

  // Add paragraph indent (TODO: with bug #311 workaround)
  set par(justify: true, first-line-indent: 1.8em )
  show par: set block(spacing: 0.5em)
  show heading: it => {
    it
    par(text(size:0.00em, h(0.0em)))
  }
  show figure: it => {
    it
    par(text(size:0.00em, h(0.0em)))
  }
  show image: it => {
    it
    par(text(size:0.00em, h(0.0em)))
  }

  // Add table caption to top right
  show figure.where(kind: table): it => box(width:100%)[
    #v(if it.has("gap") {it.gap} else {0.65em})
    #set align(right)
    #set par(hanging-indent: 1cm, justify: true)
    #pad(x: 0cm)[#it.caption]
    #align(center)[#it.body]
  ]

  // = Math config
  
  set math.equation(
    numbering: "(1)",
    supplement: none,
  )
  
  show ref: it => {
    // provide custom reference for equations
    if it.element != none and it.element.func() == math.equation {
      // optional: wrap inside link, so whole label is linked
      link(it.target)[(#it)]
    } else {
      it
    }
  }
  
  body
}

// = Code config

// Import nice listing library (remove when not needed)
#import "@preview/codelst:1.0.0": sourcecode
#let sourcecode = sourcecode.with(
  frame: block.with(
    fill: white,
    radius: 1em,
    inset: (rest: 0.8em),
    stroke: (paint: gray, thickness: 1pt, dash: "solid")
  )
)

// Paste code from file
// TODO: This approach feels s wrong...
#let lst(source, lang) = {
  // TODO: Workaround for line indent
  set par(justify: true, first-line-indent: .0em )
  set text(size:10pt, font: ("Fira Code"))
  // Breaks umbering on long strings without spaces
  sourcecode(lang: lang)[#raw(read("../" + source))]
}

// = Funny emphasizings
#let amazed(term) = box[✨ #term ✨]
#let blazed(term) = box[🔥 #term 🔥]
#let zapped(term) = box[⚡ #term ⚡]
#let exploded(term) = box[💥 #term 💥]
#let celebrated(term) = box[🎉 #term 🎉]
