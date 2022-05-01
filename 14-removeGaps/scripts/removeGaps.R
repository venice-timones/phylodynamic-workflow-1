#### Libraries
library(seqinr)
library(ape)
library(Biostrings)

#### Read FASTA
sequenceAligned <- readDNAStringSet(file = paste0("input/", list.files(path = "input/", pattern=".*fasta")))

#### Extract the labels 
sequenceLabels <- row.names(data.frame(sequenceAligned))

#### Convert FASTA to matrix form
sequenceAlignedMatrix <- as.matrix(sequenceAligned)

#### Remove gaps
sequenceAlignedTrimmed <- del.colgapsonly(sequenceAlignedMatrix, 
                                          threshold = 0.01, 
                                          freq.only = FALSE)
sequenceAlignedTrimmed <- as.list(sequenceAlignedTrimmed) 
sequenceAlignedTrimmed <- as.character(sequenceAlignedTrimmed) 

#### Save trimmed to FASTA
write.fasta(sequences = sequenceAlignedTrimmed, 
            names = sequenceLabels, 
            file.out = gsub('.fasta', 'Trimmed.fasta', gsub('input', 'output', paste0("input/", list.files(path = "input/", pattern=".*fasta")))))

