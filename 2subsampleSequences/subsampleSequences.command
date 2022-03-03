#! /bin/bash

# Preliminaries
cd GitHub/gisaid-preprocessing/2subsampleSequences
source activate nextstrain

### EDIT SECTION ###
# Declare region names
declare regions=("barmm" "caraga" "davao" "northmindanao" "soccsksargen" "zamboanga")
declare regionsName=("Bangsamoro Autonomous Region In Muslim Mindanao" "Caraga" "Davao Region" "Northern Mindanao" "Soccsksargen" "Zamboanga Peninsula")

# Subsample to specific region
declare -i i=0
for region in ${regions[@]}; do
    augur filter \
        --metadata input/*.tsv \
        --query "division == '${regionsName[i]}'" \
        --exclude-ambiguous-dates-by any \
        --output-strains output/${region}.txt
    augur filter \
        --metadata input/*.tsv \
        --sequences input/*.fasta \
        --exclude-all \
        --include output/${region}.txt \
        --output-metadata output/${region}.tsv \
        --output-sequences output/${region}.fasta
    rm output/${region}.txt
    i=i+1
done

# Subsample to mindanao
augur filter \
    --metadata input/*.tsv \
    --query "((division == 'Zamboanga Peninsula') | (division == 'Northern Mindanao') | (division == 'Davao Region') | (division == 'Soccsksargen') | (division == 'Caraga') | (division == 'Bangsamoro Autonomous Region In Muslim Mindanao'))" \
    --exclude-ambiguous-dates-by any \
    --output-strains output/mindanao.txt
augur filter \
    --metadata input/*.tsv \
    --sequences input/*.fasta \
    --exclude-all \
    --include output/mindanao.txt \
    --output-metadata output/mindanao.tsv \
    --output-sequences output/mindanao.fasta
rm output/mindanao.txt