# medlemskap-oppslag-pdfgen

Malene i dette repoet er skrevet i [Typst](https://typst.app/) og bygges inn i
[navikt/pdfgenrs](https://github.com/navikt/pdfgenrs) sitt Docker-image.

MAC:
For kjøre PDF-gen lokalt må docker først være oppe. Deretter kjøre scriptet run_development.sh.
Det blir da generert en docker container som en kan gå inn på gjennom localhost:8080

Legg til path for templaten som en ønsker å kjøre til URL'en, f.eks. medlemskapvurdert.
Det skal da se noe slikt ut: http://localhost:8080/api/v1/genpdf/medlemskapresultater/medlemskapvurdert

I motsetning til den gamle Handlebars-baserte løsningen leser pdfgenrs Typst-malene kun ved
oppstart. `run_development.sh` overvåker derfor `templates/`, `data/`, `fonts/` og `resources/`
og restarter containeren automatisk når noe endres.