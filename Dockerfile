FROM ghcr.io/navikt/pdfgenrs:1.0.31

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
COPY data /app/data
