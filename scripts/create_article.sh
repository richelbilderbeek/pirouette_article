#!/bin/bash
#
# Creates the PDF version of the article.
#
# Usage:
#
#   ./scripts/create_article.sh
#
#

pdflatex article --shell-escape
bibtex article
pdflatex article --shell-escape
pdflatex article --shell-escape
