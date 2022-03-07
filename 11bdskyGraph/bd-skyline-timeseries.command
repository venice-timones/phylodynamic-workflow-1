#! /bin/bash

###EDIT THIS ONLY!!!###
declare -r date=211102

##### PLOT TEMPORAL SIGNAL
cd GitHub
cd phylodynamic-visualizations
cd bd-skyline-timeseries

Rscript bd-skyline-timeseries.R $date
