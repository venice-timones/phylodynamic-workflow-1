#! /bin/bash

# Preliminaries
cd GitHub/phylodynamic-workflow/14-removeGaps

# Remove gaps
Rscript ./scripts/removeGaps.R 

# FASTA to uppercase
declare fasta=$(ls output/*fasta)
awk '/^>/ {print($0)}; /^[^>]/ {print(toupper($0))}' ${fasta} > output/tempt.fasta
rm ${fasta}
mv output/tempt.fasta ${fasta}