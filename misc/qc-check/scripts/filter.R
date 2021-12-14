setwd("/Users/ijborda/GitHub/gisaid-preprocessing/misc/qc-check")
wd = getwd()

#load dateframe
qc.result.start <- read.delim(file = "qc-check.result.tsv", sep = '\t', header = TRUE)
status.col <- as.vector(c("seqName","qc.missingData.status","qc.mixedSites.status","qc.privateMutations.status","qc.snpClusters.status","qc.frameShifts.status","qc.stopCodons.status"))
qc.result.clean <- qc.result.start[,status.col]

# 1 - Fail, 0 - Pass
qc.result.clean$qc.status <- ifelse(grepl("mediocre|bad",qc.result.clean$qc.missingData.status) |
                                    grepl("mediocre|bad",qc.result.clean$qc.mixedSites.status) |
                                    grepl("mediocre|bad",qc.result.clean$qc.privateMutations.status) |
                                    grepl("mediocre|bad",qc.result.clean$qc.snpClusters.status) |
                                    grepl("mediocre|bad",qc.result.clean$qc.frameShifts.status) |
                                    grepl("mediocre|bad",qc.result.clean$qc.stopCodons.status)
                                    ,1,0)

#remove unclean rows and retain only first column
qc.result.end <- qc.result.clean[qc.result.clean$qc.status != 1, ]
qc.result.end <- qc.result.end[,as.vector(c("seqName"))]

#save result
write.table(qc.result.end,file="qc-check.filter.txt", sep="\t", row.names=FALSE, col.names = FALSE,quote = FALSE)



