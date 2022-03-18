# Phylodynamic workflow for SARS-CoV-2

Collection of scripts used for performing bottom-up phylodynamic analysis. Starts with the data collected from [GISAID](https://www.gisaid.org) using [Augur](https://docs.nextstrain.org/projects/augur/en/stable/index.html) format.

The workflow includes subsampling, alignment, quality checking, computation of priors for BEAST analysis, up to visualizing the results. 

The workflow uses the package following packages. Install these preferably via [miniconda](https://docs.conda.io/en/latest/miniconda.html).
* [Augur](https://anaconda.org/bioconda/augur)
* [Nextalign](https://anaconda.org/bioconda/nextalign)
* [Nextclade](https://anaconda.org/bioconda/nextclade)

Moreover, install also [R](https://cran.r-project.org/bin/windows/base/) and [R studio](https://www.rstudio.com/products/rstudio/download/) (optional).