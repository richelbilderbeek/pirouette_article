#!/bin/bash
#
# Creates the PDF version of the article.
#
# Usage:
#
#   ./scripts/create_article
#
#

pandoc response_letter/README.md -o response_letter.pdf
