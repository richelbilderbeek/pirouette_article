#!/bin/bash
#
# Usage:
#
#   ./scripts/spell_check.sh
#

Rscript -e 'spelling::spell_check_files("content.tex", ignore = readLines("inst/WORDLIST"))'

