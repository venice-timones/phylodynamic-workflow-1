#! /bin/bash

###EDIT THIS ONLY!!!###
declare -r date=211102

##### PRELIMINARIES
#Initialize environment
cd GitHub
cd gisaid-preprocessing
cd ncov-master
source activate nextstrain

##### RENAME
Rscript ./scripts/rename.R $date.bdmm

##### DAVAO
#Subsample to specific region
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --query "division == 'Davao'" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.davao.align.filter.txt
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --sequences align/$date.bdmm.sequences.sanitized.clean.aligned.fasta \
    --exclude-all \
    --include intermediate/$date.davao.align.filter.txt \
    --output-metadata align/$date.davao.metadata.sanitized.clean.aligned.tsv \
    --output-sequences align/$date.davao.sequences.sanitized.clean.aligned.fasta

##### ZAMBOANGA
#Subsample to specific region
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --query "division == 'Zamboanga'" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.zamboanga.align.filter.txt
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --sequences align/$date.bdmm.sequences.sanitized.clean.aligned.fasta \
    --exclude-all \
    --include intermediate/$date.zamboanga.align.filter.txt \
    --output-metadata align/$date.zamboanga.metadata.sanitized.clean.aligned.tsv \
    --output-sequences align/$date.zamboanga.sequences.sanitized.clean.aligned.fasta

##### NORTHERN MINDANAO
#Subsample to specific region
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --query "division == 'Northern Mindanao'" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.northmindanao.align.filter.txt
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --sequences align/$date.bdmm.sequences.sanitized.clean.aligned.fasta \
    --exclude-all \
    --include intermediate/$date.northmindanao.align.filter.txt \
    --output-metadata align/$date.northmindanao.metadata.sanitized.clean.aligned.tsv \
    --output-sequences align/$date.northmindanao.sequences.sanitized.clean.aligned.fasta

##### SOCCSKARGEN
#Subsample to specific region
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --query "division == 'Soccsksargen'" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.soccsksargen.align.filter.txt
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --sequences align/$date.bdmm.sequences.sanitized.clean.aligned.fasta \
    --exclude-all \
    --include intermediate/$date.soccsksargen.align.filter.txt \
    --output-metadata align/$date.soccsksargen.metadata.sanitized.clean.aligned.tsv \
    --output-sequences align/$date.soccsksargen.sequences.sanitized.clean.aligned.fasta

##### CARAGA
#Subsample to specific region
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --query "division == 'Caraga'" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.caraga.align.filter.txt
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --sequences align/$date.bdmm.sequences.sanitized.clean.aligned.fasta \
    --exclude-all \
    --include intermediate/$date.caraga.align.filter.txt \
    --output-metadata align/$date.caraga.metadata.sanitized.clean.aligned.tsv \
    --output-sequences align/$date.caraga.sequences.sanitized.clean.aligned.fasta

##### BARMM
#Subsample to specific region
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --query "division == 'BARMM'" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.barmm.align.filter.txt
augur filter \
    --metadata align/$date.bdmm.metadata.sanitized.clean.aligned.tsv \
    --sequences align/$date.bdmm.sequences.sanitized.clean.aligned.fasta \
    --exclude-all \
    --include intermediate/$date.barmm.align.filter.txt \
    --output-metadata align/$date.barmm.metadata.sanitized.clean.aligned.tsv \
    --output-sequences align/$date.barmm.sequences.sanitized.clean.aligned.fasta

##### CREATE DATE FILES
Rscript ./scripts/date.R $date.bdmm
Rscript ./scripts/date.R $date.davao
Rscript ./scripts/date.R $date.zamboanga
Rscript ./scripts/date.R $date.northmindanao
Rscript ./scripts/date.R $date.soccsksargen
Rscript ./scripts/date.R $date.caraga
Rscript ./scripts/date.R $date.barmm

