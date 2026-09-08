// JSON data blir injisert av serveren som en virtuell fil på
// /data/medlemskapresultater/medlemskapvurdert.json.
#import "/templates/medlemskapresultater/common.typ": layout, personalia, automatisk_notat, is_true

#let data = json("/data/medlemskapresultater/medlemskapvurdert.json")
#let fom = data.at("fom", default: "")
#let tom = data.at("tom", default: "")
#let navn = data.at("navn", default: "")
#let fnr = data.at("fnr", default: "")
#let tidspunkt = data.at("tidspunkt", default: "")
#let erTredjelandsborger = data.at("erTredjelandsborger", default: false)
#let erNorskStatsborger = data.at("erNorskStatsborger", default: false)
#let brukerSporsmalArbeidUtlandNy = data.at("brukerSpørsmålArbeidUtlandNy", default: false)
#let brukerSporsmalOppholdUtenforEOS = data.at("brukerSpørsmålOppholdUtenforEØS", default: false)
#let brukerSporsmalOppholdUtenforNorge = data.at("brukerSpørsmålOppholdUtenforNorge", default: false)
#let brukerSporsmalOppholdstillatelse = data.at("brukerSpørsmålOppholdstillatelse", default: false)

#layout(
  title: "Bruker er medlem i folketrygden. Automatisk vurdering gjort i forbindelse med krav om sykepenger for perioden " + fom + " - " + tom,
  tidspunkt: tidspunkt,
)[
#linebreak()
  #personalia(navn, fnr)
#linebreak()
  = Du er medlem i folketrygden pr. #fom.
  #linebreak()

  #text(size: 12pt)[
    Vurderingen av medlemskapet ditt er behandlet automatisk, og vurderingen er basert på opplysninger om deg fra:
  ]

  #text(size: 12pt)[
    #list(
      [Nav sitt medlemskapsregister MEDL],
      [Folkeregisteret],
      [Arbeidstaker- og arbeidsgiverregisteret],
      [Enhetsregisteret],
      ..if is_true(erTredjelandsborger) { ([Utlendingsdirektoratet],) } else { () },
      [
        Søknaden om sykepenger og spørsmål om:
        #list(
          marker: "◦",
          ..if is_true(brukerSporsmalArbeidUtlandNy) or is_true(data.at("brukerSpørsmålArbeidUtlandGammel", default: false)) { ([Arbeid utenfor Norge],) } else { () },
          ..if is_true(brukerSporsmalOppholdUtenforEOS) { ([Opphold utenfor EØS-området],) } else { () },
          ..if is_true(brukerSporsmalOppholdUtenforNorge) { ([Opphold utenfor Norge],) } else { () },
          ..if is_true(brukerSporsmalOppholdstillatelse) { ([Oppholdstillatelse],) } else { () },
        )
      ],
    )
#linebreak()
    Vurderingen forutsetter:
    #list(
      [at du ikke har utført noe arbeid utenfor Norge de siste 12 månedene],
      [at du ikke oppholder deg i utlandet uten Nav sin godkjenning når det er nødvendig, se folketrygdloven § 8-9 andre ledd],
      [at du ikke er tjenestemann og ansatt i en forvaltning i et annet EØS-land.],
      [at du ikke mottar kontantytelser fra et annet EØS-land som faller inn under trygdeforordning (EF) 883/2004 artikkel 11 nr. 2],
      ..if not is_true(erNorskStatsborger) { ([at du ikke er ansatt for en fremmed stat eller en mellomfolkelig organisasjon],) } else { () },
    )
  ]
#linebreak()
  #automatisk_notat[Notatet er opprettet automatisk i forbindelse med søknad om sykepenger for perioden #fom - #tom]
  #automatisk_notat[Vurderingen er gjort av Arbeids- og velferdsdirektoratets system for automatisk vurdering av lovvalg og medlemskap (systemet "LovMe").]
]
