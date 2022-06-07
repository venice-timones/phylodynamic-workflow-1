# Phylodynamic workflow for SARS-CoV-2

Collection of scripts used for performing bottom-up phylodynamic analysis. Starts with the data collected from [GISAID](https://www.gisaid.org) using [Augur](https://docs.nextstrain.org/projects/augur/en/stable/index.html) format.

## About

The workflow includes subsampling, alignment, quality checking, computation of priors for BEAST analysis, up to visualizing the results. 

## Installation

Install [miniconda](https://docs.conda.io/en/latest/miniconda.html). Afterwards, install the required packages by running the following command. This creates a conda environment called `phylodynamics` with all the needed packages ([Augur](https://anaconda.org/bioconda/augur), [Nextalign](https://anaconda.org/bioconda/nextalign), [Nextclade](https://anaconda.org/bioconda/nextclade)).

```
conda env create --file phylodynamicsEnv.yml
```

Install also [R](https://cran.r-project.org/bin/windows/base/) and [R studio](https://www.rstudio.com/products/rstudio/download/) (optional).

## Usage

Each step in the workflow is modularized. Perform a specific step by executing the corresponding `.command` file. Details on what input files are needed and what output files would be created are in the `README.md` file of each folder. Note that all dates should be in the `YYYY-MM-DD` format.