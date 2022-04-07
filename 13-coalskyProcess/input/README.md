# Coalescent Skyline
## Input

* Per region Ne data exported from the Tracer. Remove title in each datafile.
  * `zamboanga.tsv`
  * `soccsksargen.tsv`
  * `northmindanao.tsv`
  * `davao.tsv`
  * `caraga.tsv`
  * `barmm.tsv`
* Metadata of Mindanao samples (for sampling dates).
  * `mindanao.tsv`
* DOH Data drop (for reported cases). Note: This dataset was removed in the example due to large size.
  * `220303.DOH.batch0.csv`
  * `220303.DOH.batch1.csv`
  * `220303.DOH.batch2.csv`
  * `220303.DOH.batch3.csv`
* Info of the Mindanao samples (for date of the most recent sample for each region)
  * `info.csv`

Note: DOH files were not included in git due to their very large size. Graphs starts at 2021-01-01. 