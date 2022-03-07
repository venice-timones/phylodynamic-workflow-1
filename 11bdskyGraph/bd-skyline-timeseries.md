# Coalescent Skyline
## Input

* Per region log file from BEAST output.
  * `211102.bdsky.zamboanga.posterior.log`
  * `211102.bdsky.soccsksargen.posterior.log`
  * `211102.bdsky.northmindanao.posterior.log`
  * `211102.bdsky.davao.posterior.log`
  * `211102.bdsky.caraga.posterior.log`
  * `211102.bdsky.barmm.posterior.log`
* Metadata of BDMM aligned (for sampling dates).
  * `211102.bdmm.metadata.sanitized.clean.aligned.tsv`
* DOH Data drop (for reported cases). Note: This dataset was removed in the example due to large size.
  * `211102.DOH.batch0.csv`
  * `211102.DOH.batch1.csv`
  * `211102.DOH.batch2.csv`
* Info of the BDMM aligned (for date of the most recent sample for each region)
  * `211102.bdmm.info.csv`

Note: Log files and DOH files were not included here due to their very large size. 

## R setting

* The maximum and minimum dates to plot
  * `minimum = "2021-01-01"`
  * `maximum = "2021-08-31"`

## Output

* One file containing the Re estimates per region.
  * `211102.re.png`
* One file containing the Re estimates per region against sampling dates.
  * `211102.re.sampling.png`
* One file containing the Re estimates per region against reported cases.
  * `211102.re.cases.png`
* Six files (one per region) containing the Re estimates (lower, upper, and median) used in the graphs.
  * `211102.barmm.re.2021.csv`
  * `211102.caraga.re.2021.csv`
  * `211102.davao.re.2021.csv`
  * `211102.northmindanao.re.2021.csv`
  * `211102.soccsksargen.re.2021.csv`
  * `211102.zamboanga.re.2021.csv`
* Six files (one per region) containing the reported cases (from DOH data drop) used in the graphs.
  * `211102.barmm.reported.2021.csv`
  * `211102.caraga.reported.2021.csv`
  * `211102.davao.reported.2021.csv`
  * `211102.northmindanao.reported.2021.csv`
  * `211102.soccsksargen.reported.2021.csv`
  * `211102.zamboanga.reported.2021.csv`

