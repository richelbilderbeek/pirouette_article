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
# Prerequisites:
#
#   sudo apt-get install pdftk
#

pdftk pirouette_article.pdf cat 1-24 output main.pdf
pdftk pirouette_article.pdf cat 25-end output supp_mat.pdf
