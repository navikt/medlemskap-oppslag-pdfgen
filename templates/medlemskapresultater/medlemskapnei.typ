// JSON data blir injisert av serveren som en virtuell fil på
// /data/medlemskapresultater/medlemskapnei.json.
#import "/templates/medlemskapresultater/common.typ": layout, personalia, automatisk_notat, is_true

#let data = json("/data/medlemskapresultater/medlemskapnei.json")
#let fom = data.at("fom", default: "")
#let tom = data.at("tom", default: "")
#let navn = data.at("navn", default: "")
#let fnr = data.at("fnr", default: "")
#let tidspunkt = data.at("tidspunkt", default: "")
#let ytelse = data.at("ytelse", default: "")
#let lovvalgsland = data.at("lovvalgsland", default: "")
#let medlfom = data.at("medlfom", default: "")
#let medltom = data.at("medltom", default: "")
#let erTredjelandsborger = data.at("erTredjelandsborger", default: false)

#layout(
  title: "Automatisk vurdering - Ikke medlem i folketrygden per " + fom,
  tidspunkt: tidspunkt,
)[
#linebreak()
  #personalia(navn, fnr)
#linebreak()

  = Du er ikke medlem i folketrygden i perioden #fom - #tom.
  #linebreak()

  #text(size: 12pt)[
    Resultatet av vurderingen er at du er omfattet av trygdelovgivningen i #lovvalgsland og du er derfor ikke medlem i folketrygden i perioden #medlfom - #medltom. \
    #linebreak()
    Vurderingen er basert på opplysninger om deg fra:
  ]

  #text(size: 12pt)[
    #list(
      [Utenlandske trygdemyndigheter (Nav sitt medlemskapsregister MEDL)],
      [Folkeregisteret],
      [Arbeidstaker- og arbeidsgiverregisteret],
      [Enhetsregisteret],
      ..if is_true(erTredjelandsborger) { ([Utlendingsdirektoratet],) } else { () },
    )
#linebreak()
    Vurderingen forutsetter at du er omfattet av et annet lands trygdelovgivning, og at arbeidsforhold og/eller arbeidsmønster ikke har endret seg etter at du begynte å jobbe i Norge.
  ]

#linebreak()
  #automatisk_notat[Notatet er opprettet automatisk i forbindelse med søknad om #ytelse for perioden #fom - #tom]
  #automatisk_notat[Vurderingen er gjort av Arbeids- og velferdsdirektoratets system for automatisk vurdering av lovvalg og medlemskap (systemet "LovMe").]
]
