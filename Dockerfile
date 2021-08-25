FROM navikt/pdfgen:29c15add3761a35f560ff3469a3a91e52fb1f38e

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
