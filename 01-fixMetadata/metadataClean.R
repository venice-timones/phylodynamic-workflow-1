### Load libraries
library("data.table")

### Function to make region names consistent with long_lat file.
rename <- function(metadata) {
  # Change Autonomous Region In Muslim Mindanao to Bangsamoro Autonomous Region In Muslim Mindanao
  metadata$division <- ifelse(metadata$division == "Autonomous Region In Muslim Mindanao", "Bangsamoro Autonomous Region In Muslim Mindanao", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Autonomous Region In Muslim Mindanao", "Bangsamoro Autonomous Region In Muslim Mindanao", metadata$division_exposure) 

  # Change Bangsamoro Autonomous Region in Muslim Mindanao to Bangsamoro Autonomous Region In Muslim Mindanao
  metadata$division <- ifelse(metadata$division == "Bangsamoro Autonomous Region in Muslim Mindanao", "Bangsamoro Autonomous Region In Muslim Mindanao", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Bangsamoro Autonomous Region in Muslim Mindanao", "Bangsamoro Autonomous Region In Muslim Mindanao", metadata$division_exposure) 
  
  # Change Caloocan City to National Capital Region
  metadata$division <- ifelse(metadata$division == "Caloocan City", "National Capital Region", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Caloocan City", "National Capital Region", metadata$division_exposure) 
  
  # Change Davao to Davao Region
  metadata$division <- ifelse(metadata$division == "Davao", "Davao Region", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Davao", "Davao Region", metadata$division_exposure) 
  
  # Change Manila to National Capital Region
  metadata$division <- ifelse(metadata$division == "Manila", "National Capital Region", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Manila", "National Capital Region", metadata$division_exposure) 
  
  # Change Manila City to National Capital Region
  metadata$division <- ifelse(metadata$division == "Manila City", "National Capital Region", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Manila City", "National Capital Region", metadata$division_exposure) 
  
  # Change NCR to National Capital Region
  metadata$division <- ifelse(metadata$division == "NCR", "National Capital Region", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "NCR", "National Capital Region", metadata$division_exposure) 
  
  # Change Navotas City to National Capital Region
  metadata$division <- ifelse(metadata$division == "Navotas City", "National Capital Region", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Navotas City", "National Capital Region", metadata$division_exposure) 
  
  # Change Pasay City to National Capital Region
  metadata$division <- ifelse(metadata$division == "Pasay City", "National Capital Region", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Pasay City", "National Capital Region", metadata$division_exposure) 
  
  # Change Quezon City to National Capital Region
  metadata$division <- ifelse(metadata$division == "Quezon City", "National Capital Region", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Quezon City", "National Capital Region", metadata$division_exposure) 
  
  # Change Region III to Central Luzon
  metadata$division <- ifelse(metadata$division == "Region III", "Central Luzon", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Region III", "Central Luzon", metadata$division_exposure) 
  
  # Change Region IV-A to Calabarzon
  metadata$division <- ifelse(metadata$division == "Region IV-A", "Calabarzon", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Region IV-A", "Calabarzon", metadata$division_exposure) 
  
  # Change Region IV-B to Mimaropa
  metadata$division <- ifelse(metadata$division == "Region IV-B", "Mimaropa", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Region IV-B", "Mimaropa", metadata$division_exposure) 
  
  # Change Region IX to Zamboanga Peninsula
  metadata$division <- ifelse(metadata$division == "Region IX", "Zamboanga Peninsula", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Region IX", "Zamboanga Peninsula", metadata$division_exposure) 
  
  # Change Region V to Bicol
  metadata$division <- ifelse(metadata$division == "Region V", "Bicol", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Region V", "Bicol", metadata$division_exposure) 
  
  # Change Region VI to Western Visayas
  metadata$division <- ifelse(metadata$division == "Region VI", "Western Visayas", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Region VI", "Western Visayas", metadata$division_exposure) 
  
  # Change Region VIII (Eastern Visayas) to Eastern Visayas
  metadata$division <- ifelse(metadata$division == "Region VIII (Eastern Visayas)", "Eastern Visayas", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Region VIII (Eastern Visayas)", "Eastern Visayas", metadata$division_exposure) 
  
  # Change Region X (Northern Mindanao) to Northern Mindanao
  metadata$division <- ifelse(metadata$division == "Region X (Northern Mindanao)", "Northern Mindanao", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Region X (Northern Mindanao)", "Northern Mindanao", metadata$division_exposure) 
  
  # Change Region XI (Davao Region) to Davao Region
  metadata$division <- ifelse(metadata$division == "Region XI (Davao Region)", "Davao Region", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Region XI (Davao Region)", "Davao Region", metadata$division_exposure) 
  
  # Change Region XII (Soccsksargen) to Soccsksargen
  metadata$division <- ifelse(metadata$division == "Region XII (Soccsksargen)", "Soccsksargen", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Region XII (Soccsksargen)", "Soccsksargen", metadata$division_exposure) 
  
  # Change Taguig City to National Capital Region
  metadata$division <- ifelse(metadata$division == "Taguig City", "National Capital Region", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Taguig City", "National Capital Region", metadata$division_exposure) 
  
  # Change Zamboanga to Zamboanga Peninsula
  metadata$division <- ifelse(metadata$division == "Zamboanga", "Zamboanga Peninsula", metadata$division) 
  metadata$division_exposure <- ifelse(metadata$division_exposure == "Zamboanga", "Zamboanga Peninsula", metadata$division_exposure) 

  # Drop quotes for columns: originating_lab, submitting_lab, and	authors
  metadata$originating_lab <-  gsub('"', '', metadata$originating_lab) 
  metadata$submitting_lab <-  gsub('"', '', metadata$submitting_lab) 
  metadata$authors <-  gsub('"', '', metadata$authors) 
  
  # Return metadata
  return (metadata)
}

### Main Function

### Get all tar files
input <- list.files(pattern=".*tar$")

### Loop through each tar files
for (tar in input) {
  # Unzip tar file
  untar(tar)
  # Save metadata file name
  tsvFileName <- list.files(pattern=".*tsv$")
  # Read metadata file
  tsvFile <- read.delim(tsvFileName, sep="\t")
  # Apply rename function
  tsvFile <- rename(tsvFile)
  # Delete original metadata file
  file.remove(list.files(pattern=".*tsv$"))
  # Save new metadata file
  fwrite(tsvFile, tsvFileName, sep="\t", quote = FALSE) 
  # Delete original tar file
  file.remove(tar)
  # Make new tar with renamed metadata
  tar(tar, list.files(pattern=".*(tsv|fasta|txt|json)$"), compression = 'gzip', tar="tar")
  # Remove files
  file.remove(list.files(pattern=".*(tsv|fasta|txt|json)$"))
}
