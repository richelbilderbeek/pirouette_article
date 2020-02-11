#!/bin/bash
#
# Creates the PDF version of the article.
#
# Usage:
#
#   ./scripts/create_article.sh
#
#

pdflatex article.tex --shell-escape
bibtex article.aux
pdflatex article.tex --shell-escape
pdflatex article.tex --shell-escape
