#! /bin/bash

###EDIT THIS ONLY!!!###
declare -r date=211102

##### PRELIMINARIES
#Initialize environment
cd Augur
cd ncov-master
source activate nextstrain
#Concatenate batches to make one set of file for Philippine samples
cat preprocess/$date.batch1.sequences.fasta \
    preprocess/$date.batch2.sequences.fasta \
    preprocess/$date.batch3.sequences.fasta \
    preprocess/$date.batch4.sequences.fasta \
    > preprocess/$date.ph.sequences.fasta
cat preprocess/$date.batch1.metadata.tsv \
    <(tail +2 preprocess/$date.batch2.metadata.tsv) \
    <(tail +2 preprocess/$date.batch3.metadata.tsv) \
    <(tail +2 preprocess/$date.batch4.metadata.tsv) \
    > preprocess/$date.ph.metadata.tsv
#Sanitize both sequence and metadata files
python3 scripts/sanitize_sequences.py \
    --sequences preprocess/$date.ph.sequences.fasta \
    --strip-prefixes "hCoV-19/" \
    --output preprocess/$date.ph.sequences.sanitized.fasta
python3 scripts/sanitize_metadata.py \
    --metadata preprocess/$date.ph.metadata.tsv \
    --database-id-columns "Accession ID" \
    --parse-location-field Location \
    --rename-fields 'Virus name=strain' 'Accession ID=gisaid_epi_isl' 'Collection date=date' 'Lineage=pangolin_lineage' 'Gender=sex'\
    --strip-prefixes "hCoV-19/" \
    --output preprocess/$date.ph.metadata.sanitized.tsv
#Create index file (base counts)
augur index \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --output preprocess/$date.ph.index.sanitized.tsv

##### NCR
#Subsample to specific region
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --query "(division == 'NCR') or (division == 'National Capital Region')" \
    --exclude-ambiguous-dates-by any \
    --output-strains preprocess/$date.ncr.filter.txt
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.ncr.filter.txt \
    --output-metadata preprocess/$date.ncr.metadata.sanitized.tsv \
    --output-sequences preprocess/$date.ncr.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='data/sars-cov-2' \
   --input-fasta=preprocess/$date.ncr.sequences.sanitized.fasta \
   --output-tsv=preprocess/$date.ncr.qc.result.tsv \
   --output-dir=output/
Rscript ./scripts/filter.R $date.ncr
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.ncr.filter.clean.txt \
    --output-metadata preprocess/$date.ncr.metadata.sanitized.clean.tsv \
    --output-sequences preprocess/$date.ncr.sequences.sanitized.clean.fasta

##### DAVAO
#Subsample to specific region
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --query "(division == 'Davao Region') or (division == 'Davao')" \
    --exclude-ambiguous-dates-by any \
    --output-strains preprocess/$date.davao.filter.txt
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.davao.filter.txt \
    --output-metadata preprocess/$date.davao.metadata.sanitized.tsv \
    --output-sequences preprocess/$date.davao.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='data/sars-cov-2' \
   --input-fasta=preprocess/$date.davao.sequences.sanitized.fasta \
   --output-tsv=preprocess/$date.davao.qc.result.tsv \
   --output-dir=output/
Rscript ./scripts/filter.R $date.davao
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.davao.filter.clean.txt \
    --output-metadata preprocess/result/$date.davao.metadata.sanitized.clean.tsv \
    --output-sequences preprocess/result/$date.davao.sequences.sanitized.clean.fasta

##### ZAMBOANGA
#Subsample to specific region
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --query "(division == 'Region IX') or (division == 'Zamboanga')" \
    --exclude-ambiguous-dates-by any \
    --output-strains preprocess/$date.zamboanga.filter.txt
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.zamboanga.filter.txt \
    --output-metadata preprocess/$date.zamboanga.metadata.sanitized.tsv \
    --output-sequences preprocess/$date.zamboanga.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='data/sars-cov-2' \
   --input-fasta=preprocess/$date.zamboanga.sequences.sanitized.fasta \
   --output-tsv=preprocess/$date.zamboanga.qc.result.tsv \
   --output-dir=output/
Rscript ./scripts/filter.R $date.zamboanga
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.zamboanga.filter.clean.txt \
    --output-metadata preprocess/result/$date.zamboanga.metadata.sanitized.clean.tsv \
    --output-sequences preprocess/result/$date.zamboanga.sequences.sanitized.clean.fasta

##### NORTHERN MINDANAO
#Subsample to specific region
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --query "division == 'Northern Mindanao'" \
    --exclude-ambiguous-dates-by any \
    --output-strains preprocess/$date.northmindanao.filter.txt
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.northmindanao.filter.txt \
    --output-metadata preprocess/$date.northmindanao.metadata.sanitized.tsv \
    --output-sequences preprocess/$date.northmindanao.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='data/sars-cov-2' \
   --input-fasta=preprocess/$date.northmindanao.sequences.sanitized.fasta \
   --output-tsv=preprocess/$date.northmindanao.qc.result.tsv \
   --output-dir=output/
Rscript ./scripts/filter.R $date.northmindanao
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.northmindanao.filter.clean.txt \
    --output-metadata preprocess/result/$date.northmindanao.metadata.sanitized.clean.tsv \
    --output-sequences preprocess/result/$date.northmindanao.sequences.sanitized.clean.fasta

##### SOCCSKARGEN
#Subsample to specific region
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --query "division == 'Soccsksargen'" \
    --exclude-ambiguous-dates-by any \
    --output-strains preprocess/$date.soccsksargen.filter.txt
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.soccsksargen.filter.txt \
    --output-metadata preprocess/$date.soccsksargen.metadata.sanitized.tsv \
    --output-sequences preprocess/$date.soccsksargen.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='data/sars-cov-2' \
   --input-fasta=preprocess/$date.soccsksargen.sequences.sanitized.fasta \
   --output-tsv=preprocess/$date.soccsksargen.qc.result.tsv \
   --output-dir=output/
Rscript ./scripts/filter.R $date.soccsksargen
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.soccsksargen.filter.clean.txt \
    --output-metadata preprocess/result/$date.soccsksargen.metadata.sanitized.clean.tsv \
    --output-sequences preprocess/result/$date.soccsksargen.sequences.sanitized.clean.fasta

##### CARAGA
#Subsample to specific region
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --query "division == 'Caraga'" \
    --exclude-ambiguous-dates-by any \
    --output-strains preprocess/$date.caraga.filter.txt
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.caraga.filter.txt \
    --output-metadata preprocess/$date.caraga.metadata.sanitized.tsv \
    --output-sequences preprocess/$date.caraga.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='data/sars-cov-2' \
   --input-fasta=preprocess/$date.caraga.sequences.sanitized.fasta \
   --output-tsv=preprocess/$date.caraga.qc.result.tsv \
   --output-dir=output/
Rscript ./scripts/filter.R $date.caraga
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.caraga.filter.clean.txt \
    --output-metadata preprocess/result/$date.caraga.metadata.sanitized.clean.tsv \
    --output-sequences preprocess/result/$date.caraga.sequences.sanitized.clean.fasta

##### BARMM
#Subsample to specific region
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --query "division == 'Bangsamoro Autonomous Region in Muslim Mindanao'" \
    --exclude-ambiguous-dates-by any \
    --output-strains preprocess/$date.barmm.filter.txt
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.barmm.filter.txt \
    --output-metadata preprocess/$date.barmm.metadata.sanitized.tsv \
    --output-sequences preprocess/$date.barmm.sequences.sanitized.fasta
#Clean the sample by using the Nextstrain QC tool
nextclade \
   --in-order \
   --input-dataset='data/sars-cov-2' \
   --input-fasta=preprocess/$date.barmm.sequences.sanitized.fasta \
   --output-tsv=preprocess/$date.barmm.qc.result.tsv \
   --output-dir=output/
Rscript ./scripts/filter.R $date.barmm
augur filter \
    --metadata preprocess/$date.ph.metadata.sanitized.tsv \
    --sequence-index preprocess/$date.ph.index.sanitized.tsv \
    --sequences preprocess/$date.ph.sequences.sanitized.fasta \
    --exclude-all \
    --include preprocess/$date.barmm.filter.clean.txt \
    --output-metadata preprocess/result/$date.barmm.metadata.sanitized.clean.tsv \
    --output-sequences preprocess/result/$date.barmm.sequences.sanitized.clean.fasta

##### MINDANAO
cat preprocess/result/$date.davao.sequences.sanitized.clean.fasta \
    preprocess/result/$date.northmindanao.sequences.sanitized.clean.fasta \
    preprocess/result/$date.soccsksargen.sequences.sanitized.clean.fasta \
    preprocess/result/$date.caraga.sequences.sanitized.clean.fasta \
    preprocess/result/$date.barmm.sequences.sanitized.clean.fasta \
    preprocess/result/$date.zamboanga.sequences.sanitized.clean.fasta \
    > preprocess/result/$date.mindanao.sequences.sanitized.clean.fasta
cat preprocess/result/$date.davao.metadata.sanitized.clean.tsv \
    <(tail +2 preprocess/result/$date.northmindanao.metadata.sanitized.clean.tsv) \
    <(tail +2 preprocess/result/$date.soccsksargen.metadata.sanitized.clean.tsv) \
    <(tail +2 preprocess/result/$date.caraga.metadata.sanitized.clean.tsv) \
    <(tail +2 preprocess/result/$date.barmm.metadata.sanitized.clean.tsv) \
    <(tail +2 preprocess/result/$date.zamboanga.metadata.sanitized.clean.tsv) \
    > preprocess/result/$date.mindanao.metadata.sanitized.clean.tsv

cat preprocess/$date.davao.sequences.sanitized.fasta \
    preprocess/$date.northmindanao.sequences.sanitized.fasta \
    preprocess/$date.soccsksargen.sequences.sanitized.fasta \
    preprocess/$date.caraga.sequences.sanitized.fasta \
    preprocess/$date.barmm.sequences.sanitized.fasta \
    preprocess/$date.zamboanga.sequences.sanitized.fasta \
    > preprocess/$date.mindanao.sequences.sanitized.fasta
cat preprocess/$date.davao.metadata.sanitized.tsv \
    <(tail +2 preprocess/$date.northmindanao.metadata.sanitized.tsv) \
    <(tail +2 preprocess/$date.soccsksargen.metadata.sanitized.tsv) \
    <(tail +2 preprocess/$date.caraga.metadata.sanitized.tsv) \
    <(tail +2 preprocess/$date.barmm.metadata.sanitized.tsv) \
    <(tail +2 preprocess/$date.zamboanga.metadata.sanitized.tsv) \
    > preprocess/$date.mindanao.metadata.sanitized.tsv

##### GRAPHS
Rscript ./scripts/graph.R $date.mindanao

##### COUNTS
Rscript ./scripts/count.R $date.mindanao

