### Load libraries
library("data.table")

### Function to make region names consistent with long_lat file.
fixName <- function(metadata) {
  
  ### Function to rename region name
  rename <- function(arr, correct) {
    for (loc in arr) {
      metadata[['division']] <- ifelse(metadata[['division']] == loc, correct, metadata[['division']]) 
      metadata[['division_exposure']] <- ifelse(metadata[['division_exposure']] == loc, correct, metadata[['division_exposure']]) 
    }
    return (metadata)
  }
  
  metadata <- rename(c("Autonomous Region In Muslim Mindanao", 
                       "Bangsamoro Autonomous Region in Muslim Mindanao"), 
                       "Bangsamoro Autonomous Region In Muslim Mindanao")
  
  metadata <- rename(c("Caloocan City", 
                       "NCR",
                       "Manila",
                       "Manila City",
                       "Navotas City",
                       "Pasay City",
                       "Quezon City",
                       "Taguig City"), 
                       "National Capital Region")
  
  metadata <- rename(c("Davao",
                       "Region XI (Davao Region)"), 
                       "Davao Region")
  
  metadata <- rename(c("Region III"), 
                       "Central Luzon")
  
  metadata <- rename(c("Region IV-A"), 
                       "Calabarzon")

  metadata <- rename(c("Region IV-B"), 
                       "Mimaropa")
  
  metadata <- rename(c("Region IX",
                       "Zamboanga"), 
                       "Zamboanga Peninsula")

  metadata <- rename(c("Region V"), 
                       "Bicol")
                       
  metadata <- rename(c("Region VI"), 
                       "Western Visayas")

  metadata <- rename(c("Region VIII (Eastern Visayas)"), 
                       "Eastern Visayas")

  metadata <- rename(c("Region X (Northern Mindanao)"), 
                       "Northern Mindanao")
  
  metadata <- rename(c("Region XII (Soccsksargen)"), 
                       "Soccsksargen")
  
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
  tsvFile <- fixName(tsvFile)
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
