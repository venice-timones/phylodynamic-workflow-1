# gisaid-preprocessing
Subsamples and quality checks (using nextclade) the SARS-CoV-2 sequences downloaded from GISAID. Subsampling is done per Mindanao regions (BARMM, Davao, Caraga, Northern Mindanao, and Soccsksargen). 

Usage:
1. Put gisaid metadata and sequences in `input` folder. 
2. Run `preprocess.command` to subsample and quality check per region.
3. Run `bdmm.command` to create subsample for bdmm model.
4. Run `align.command` to subsample aligned fasta file. 
