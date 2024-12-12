# medlemskap-oppslag-pdfgen

## MAC
For kjøre PDF-gen lokalt må docker først være oppe. Deretter kjøre scriptet 
```bash
./run_development.sh
```

Det blir da generert en docker container som en kan gå inn på gjennom localhost:8080

Legg til path for templaten som en ønsker å kjøre til URL'en, f.eks. medlemskapvurdert.
Det skal da se noe slikt ut: http://localhost:8080/api/v1/genpdf/medlemskapresultater/medlemskapvurdert

Endringer i templaten vil oppdateres i vinduet under runtime og vil i aller fleste tilfeller ikke behøve å refreshes

## Windows
For kjøre PDF-gen lokalt må docker først være oppe. Deretter kjøre scriptet
```bash
./run_development_windows.sh
```

Det blir da generert en docker container som en kan gå inn på gjennom localhost:8080

Legg til path for templaten som en ønsker å kjøre til URL'en, f.eks. medlemskapvurdert.
Det skal da se noe slikt ut: http://localhost:8080/api/v1/genpdf/medlemskapresultater/medlemskapvurdert

Endringer i templaten vil oppdateres i vinduet under runtime og vil i aller fleste tilfeller ikke behøve å refreshes
