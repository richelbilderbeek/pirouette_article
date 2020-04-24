#!/bin/bash
#
# Merge all .tex files to one file 'pirouette_article.tex'.
# 'pirouette_article.tex' is ignored by git
#
# Usage:
#
#   ./scripts/merge_files.sh
#
#
# 
# Follow same structure as article_header.tex

cat pirouette_content.tex \
  pirouette_supplement.tex > pirouette_article.tex

