#! /bin/bash

###EDIT THIS ONLY!!!###
declare -r date=211102

##### PRELIMINARIES
#Initialize environment
cd GitHub
cd gisaid-preprocessing
cd ncov-master
source activate nextstrain
#Concatenate batches to make one set of file for Philippine samples
cat input/$date.batch1.sequences.fasta \
    input/$date.batch2.sequences.fasta \
    input/$date.batch3.sequences.fasta \
    input/$date.batch4.sequences.fasta \
    > intermediate/$date.ph.sequences.fasta
cat input/$date.batch1.metadata.tsv \
    <(tail +2 input/$date.batch2.metadata.tsv) \
    <(tail +2 input/$date.batch3.metadata.tsv) \
    <(tail +2 input/$date.batch4.metadata.tsv) \
    > intermediate/$date.ph.metadata.tsv
#Sanitize both sequence and metadata files
python3 scripts/sanitize_sequences.py \
    --sequences intermediate/$date.ph.sequences.fasta \
    --strip-prefixes "hCoV-19/" \
    --output intermediate/$date.ph.sequences.sanitized.fasta
python3 scripts/sanitize_metadata.py \
    --metadata intermediate/$date.ph.metadata.tsv \
    --database-id-columns "Accession ID" \
    --parse-location-field Location \
    --rename-fields 'Virus name=strain' 'Accession ID=gisaid_epi_isl' 'Collection date=date' 'Lineage=pangolin_lineage' 'Gender=sex'\
    --strip-prefixes "hCoV-19/" \
    --output intermediate/$date.ph.metadata.sanitized.tsv
#Create index file (base counts)
augur index \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --output intermediate/$date.ph.index.sanitized.tsv

##### NCR
#Subsample to specific region
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --query "(division == 'NCR') or (division == 'National Capital Region')" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.ncr.filter.txt
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.ncr.filter.txt \
    --output-metadata intermediate/$date.ncr.metadata.sanitized.tsv \
    --output-sequences intermediate/$date.ncr.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='reference/sars-cov-2' \
   --input-fasta=intermediate/$date.ncr.sequences.sanitized.fasta \
   --output-tsv=intermediate/$date.ncr.qc.result.tsv \
   --output-dir=nextclade/
Rscript ./scripts/filter.R $date.ncr
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.ncr.filter.clean.txt \
    --output-metadata intermediate/$date.ncr.metadata.sanitized.clean.tsv \
    --output-sequences intermediate/$date.ncr.sequences.sanitized.clean.fasta

##### DAVAO
#Subsample to specific region
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --query "(division == 'Davao Region') or (division == 'Davao')" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.davao.filter.txt
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.davao.filter.txt \
    --output-metadata intermediate/$date.davao.metadata.sanitized.tsv \
    --output-sequences intermediate/$date.davao.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='reference/sars-cov-2' \
   --input-fasta=intermediate/$date.davao.sequences.sanitized.fasta \
   --output-tsv=intermediate/$date.davao.qc.result.tsv \
   --output-dir=nextclade/
Rscript ./scripts/filter.R $date.davao
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.davao.filter.clean.txt \
    --output-metadata output/$date.davao.metadata.sanitized.clean.tsv \
    --output-sequences output/$date.davao.sequences.sanitized.clean.fasta

##### ZAMBOANGA
#Subsample to specific region
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --query "(division == 'Region IX') or (division == 'Zamboanga')" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.zamboanga.filter.txt
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.zamboanga.filter.txt \
    --output-metadata intermediate/$date.zamboanga.metadata.sanitized.tsv \
    --output-sequences intermediate/$date.zamboanga.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='reference/sars-cov-2' \
   --input-fasta=intermediate/$date.zamboanga.sequences.sanitized.fasta \
   --output-tsv=intermediate/$date.zamboanga.qc.result.tsv \
   --output-dir=nextclade/
Rscript ./scripts/filter.R $date.zamboanga
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.zamboanga.filter.clean.txt \
    --output-metadata output/$date.zamboanga.metadata.sanitized.clean.tsv \
    --output-sequences output/$date.zamboanga.sequences.sanitized.clean.fasta

##### NORTHERN MINDANAO
#Subsample to specific region
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --query "division == 'Northern Mindanao'" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.northmindanao.filter.txt
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.northmindanao.filter.txt \
    --output-metadata intermediate/$date.northmindanao.metadata.sanitized.tsv \
    --output-sequences intermediate/$date.northmindanao.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='reference/sars-cov-2' \
   --input-fasta=intermediate/$date.northmindanao.sequences.sanitized.fasta \
   --output-tsv=intermediate/$date.northmindanao.qc.result.tsv \
   --output-dir=nextclade/
Rscript ./scripts/filter.R $date.northmindanao
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.northmindanao.filter.clean.txt \
    --output-metadata output/$date.northmindanao.metadata.sanitized.clean.tsv \
    --output-sequences output/$date.northmindanao.sequences.sanitized.clean.fasta

##### SOCCSKARGEN
#Subsample to specific region
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --query "division == 'Soccsksargen'" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.soccsksargen.filter.txt
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.soccsksargen.filter.txt \
    --output-metadata intermediate/$date.soccsksargen.metadata.sanitized.tsv \
    --output-sequences intermediate/$date.soccsksargen.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='reference/sars-cov-2' \
   --input-fasta=intermediate/$date.soccsksargen.sequences.sanitized.fasta \
   --output-tsv=intermediate/$date.soccsksargen.qc.result.tsv \
   --output-dir=nextclade/
Rscript ./scripts/filter.R $date.soccsksargen
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.soccsksargen.filter.clean.txt \
    --output-metadata output/$date.soccsksargen.metadata.sanitized.clean.tsv \
    --output-sequences output/$date.soccsksargen.sequences.sanitized.clean.fasta

##### CARAGA
#Subsample to specific region
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --query "division == 'Caraga'" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.caraga.filter.txt
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.caraga.filter.txt \
    --output-metadata intermediate/$date.caraga.metadata.sanitized.tsv \
    --output-sequences intermediate/$date.caraga.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='reference/sars-cov-2' \
   --input-fasta=intermediate/$date.caraga.sequences.sanitized.fasta \
   --output-tsv=intermediate/$date.caraga.qc.result.tsv \
   --output-dir=nextclade/
Rscript ./scripts/filter.R $date.caraga
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.caraga.filter.clean.txt \
    --output-metadata output/$date.caraga.metadata.sanitized.clean.tsv \
    --output-sequences output/$date.caraga.sequences.sanitized.clean.fasta

##### BARMM
#Subsample to specific region
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --query "division == 'Bangsamoro Autonomous Region in Muslim Mindanao'" \
    --exclude-ambiguous-dates-by any \
    --output-strains intermediate/$date.barmm.filter.txt
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.barmm.filter.txt \
    --output-metadata intermediate/$date.barmm.metadata.sanitized.tsv \
    --output-sequences intermediate/$date.barmm.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='reference/sars-cov-2' \
   --input-fasta=intermediate/$date.barmm.sequences.sanitized.fasta \
   --output-tsv=intermediate/$date.barmm.qc.result.tsv \
   --output-dir=nextclade/
Rscript ./scripts/filter.R $date.barmm
augur filter \
    --metadata intermediate/$date.ph.metadata.sanitized.tsv \
    --sequence-index intermediate/$date.ph.index.sanitized.tsv \
    --sequences intermediate/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include intermediate/$date.barmm.filter.clean.txt \
    --output-metadata output/$date.barmm.metadata.sanitized.clean.tsv \
    --output-sequences output/$date.barmm.sequences.sanitized.clean.fasta

##### MINDANAO
cat output/$date.davao.sequences.sanitized.clean.fasta \
    output/$date.northmindanao.sequences.sanitized.clean.fasta \
    output/$date.soccsksargen.sequences.sanitized.clean.fasta \
    output/$date.caraga.sequences.sanitized.clean.fasta \
    output/$date.barmm.sequences.sanitized.clean.fasta \
    output/$date.zamboanga.sequences.sanitized.clean.fasta \
    > output/$date.mindanao.sequences.sanitized.clean.fasta
cat output/$date.davao.metadata.sanitized.clean.tsv \
    <(tail +2 output/$date.northmindanao.metadata.sanitized.clean.tsv) \
    <(tail +2 output/$date.soccsksargen.metadata.sanitized.clean.tsv) \
    <(tail +2 output/$date.caraga.metadata.sanitized.clean.tsv) \
    <(tail +2 output/$date.barmm.metadata.sanitized.clean.tsv) \
    <(tail +2 output/$date.zamboanga.metadata.sanitized.clean.tsv) \
    > output/$date.mindanao.metadata.sanitized.clean.tsv

cat intermediate/$date.davao.sequences.sanitized.fasta \
    intermediate/$date.northmindanao.sequences.sanitized.fasta \
    intermediate/$date.soccsksargen.sequences.sanitized.fasta \
    intermediate/$date.caraga.sequences.sanitized.fasta \
    intermediate/$date.barmm.sequences.sanitized.fasta \
    intermediate/$date.zamboanga.sequences.sanitized.fasta \
    > intermediate/$date.mindanao.sequences.sanitized.fasta
cat intermediate/$date.davao.metadata.sanitized.tsv \
    <(tail +2 intermediate/$date.northmindanao.metadata.sanitized.tsv) \
    <(tail +2 intermediate/$date.soccsksargen.metadata.sanitized.tsv) \
    <(tail +2 intermediate/$date.caraga.metadata.sanitized.tsv) \
    <(tail +2 intermediate/$date.barmm.metadata.sanitized.tsv) \
    <(tail +2 intermediate/$date.zamboanga.metadata.sanitized.tsv) \
    > intermediate/$date.mindanao.metadata.sanitized.tsv

##### GRAPHS
Rscript ./scripts/graph.R $date.mindanao

##### COUNTS
Rscript ./scripts/count.R $date.mindanao

