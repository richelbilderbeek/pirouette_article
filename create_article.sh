#!/bin/bash
#
# Creates the PDF version of the article.
#
# Usage:
#
#   ./scripts/create_article.sh
#
#

pdflatex pirouette_header --shell-escape
bibtex pirouette_header
pdflatex pirouette_header --shell-escape
pdflatex pirouette_header --shell-escape
mv pirouette_header.pdf pirouette_article.pdf

