### Note: Directory is where the bash script is

### Load QC result
qc.result <- read.delim(file = paste0("output/", list.files(path = "output/", pattern="^[^~].*tsv$")), sep = '\t', header = TRUE)
status.col <- as.vector(c("seqName","qc.missingData.status","qc.mixedSites.status","qc.privateMutations.status","qc.snpClusters.status","qc.frameShifts.status","qc.stopCodons.status"))
qc.result <- qc.result[,status.col]

### 1 - Fail, 0 - Pass
qc.result$qc.status <- ifelse(grepl("mediocre|bad", qc.result$qc.missingData.status) |
                                grepl("mediocre|bad", qc.result$qc.mixedSites.status) |
                                grepl("mediocre|bad", qc.result$qc.privateMutations.status) |
                                grepl("mediocre|bad", qc.result$qc.snpClusters.status) |
                                grepl("mediocre|bad", qc.result$qc.frameShifts.status) |
                                grepl("mediocre|bad", qc.result$qc.stopCodons.status)
                                ,1 ,0)

### Remove unclean rows (qc.status = 1) and retain only first column
qc.result.output <- qc.result[qc.result$qc.status != 1, ]
qc.result.output <- qc.result.output[,as.vector(c("seqName"))]

### Save result
write.table(qc.result.output, file="output/qcresult.txt", sep="\t", row.names=FALSE, col.names = FALSE, quote = FALSE)