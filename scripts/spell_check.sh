#!/bin/bash
#
# Usage:
#
#   ./scripts/spell_check.sh
#

Rscript -e 'spelling::spell_check_files("content.tex", ignore = readLines("inst/WORDLIST"))'
Rscript -e 'spelling::spell_check_files("response_letter/README.md", ignore = readLines("inst/WORDLIST"))'

