// Delte funksjoner og oppsett brukt av alle maler i medlemskapresultater.

// Setter inn `divider` på gitt indeks i en verdi, f.eks. for å formatere
// fødselsnummer som "123456 78901" (tilsvarer pdfgen-helperen `insert_at`).
#let insert_at(value, idx, divider: " ") = {
  let s = str(value)
  s.slice(0, idx) + divider + s.slice(idx)
}

// Feltene i inndataene er stort sett strenger ("true"/"false"), men enkelte
// er reelle booleanske verdier. Denne dekker begge tilfeller.
#let is_true(value) = value == true or value == "true"

#let nav_logo = image("/resources/Navlogo.png", width: 1.3cm)

// Felles side- og tekstoppsett, samt topp-/bunntekst, for alle
// medlemskapresultater-maler.
#let layout(title: "", tidspunkt: "", body) = {
  set document(title: title)
  set page(
    paper: "a4",
    margin: (top: 2cm, bottom: 1.5cm, left: 1.5cm, right: 1.5cm),
    header: context {
      if counter(page).get().first() == 1 [
        #v(0.5cm)
        #grid(
          columns: (auto, 1fr),
          align: (left, right),
          nav_logo,
          place(top + right, dx: -1cm, dy: 0.4cm)[
            #text(style: "italic", size: 9pt)[
              Unntatt offentlighet etter \
              offentleglova § 13 første ledd \
              og Nav-loven § 7
            ]
          ],
        )
      ]
    },
    footer: context [
      #text(size: 9pt)[
        Opplysningene er hentet fra registrene #tidspunkt.
        #h(1fr)
        side #counter(page).display() av #counter(page).final().last()
      ]
    ],
  )
  set text(font: "Arial", size: 12pt, lang: "nb")
  set list(indent: 2em)
  show heading: set text(size: 14pt, weight: "bold")
  show heading: set block(above: 0.6em, below: 0.5em)
  body
}

// Personalia-boks, lik toppen av persontekst-blokken i de gamle malene.
#let personalia(navn, fnr) = block(above: 2cm, below: 1.2em)[
  #text(size: 12pt, weight: "bold")[Personopplysninger] \
  #linebreak()
  #text(size: 12pt)[Navn: #navn] \
  #text(size: 12pt)[Fødselsnummer: #insert_at(fnr, 6)]
]

// Kursiv, halvfet notis om at notatet/vurderingen er opprettet automatisk.
#let automatisk_notat(body) = block(above: 0.8em, below: 0.8em)[
  #text(size: 12pt, style: "italic", weight: "bold")[#body]
]
