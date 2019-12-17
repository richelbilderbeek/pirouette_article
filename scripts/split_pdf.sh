#!/bin/bash
#
# Splits the article.pdf into
#   * main.pdf
#   * supp_mat.pdf
#
# Usage:
#
#   ./scripts/split_pdf
#

pdftk article.pdf cat 1-35 output main.pdf
pdftk article.pdf cat 36-45 output supp_mat.pdf
