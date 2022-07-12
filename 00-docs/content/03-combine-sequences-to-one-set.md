# Combine Sequences To One Set

## Table of contents

- [Overview](#overview)
- [Inputs](#inputs)
- [Scripts](#scripts)
- [Output](#outputs)
- [Duplicate Headers](#duplicate-headers)

## Overview

- After successfully fixing the metadata errors, the goal of this method is to combine all the **sequences** and **metadata files** of the Regions into **one Mindanao file**.
- This is to easily group different Regions by concatenating all the data first, and then subsampling them into individual Mindanao Regions later on.

## Inputs

- The compressed files with the extension `.tar` placed inside the **output** folder from [Fixing metadata](/00-docs/content/02-fixed-known-metadata-issues.md) will be used as the input for this method.

- We must decompress the `.tar` files first. We can find one sequence (`.fasta`) file and one metadata (`.tsv`) file inside. Repeat for all the `.tar` files.

- Gather all the sequence and metadata files from each `.tar` files and place them inside the input folder. This will be further discussed in the next part.
- Expected inputs

  - 10 sequence (`.fasta`) file
  - 10 metadata (`.tstv`) file

  _Note: The number of sequence and metadata files corresponds to the number of variants in the naming of Regions in Mindanao._

## Scripts

- In order to do this method, the `02-combineSequences` folder from the repository will be use as our **main folder**. You can find the folder through this [link](../../02-combineSequences/). This folder should contain a **input folder**, an **output folder**, a **bash script**, and a **README.md** file.

- As mentioned above, the gathered `.fasta` and `.tsv` files will be placed inside the **input** folder of the `02-combineSequences` folder.

- Return to the **main folder**. Run the bashscript by double clicking the file. Choose the file with the `.command` extension for mac users and `.bat` extension for windows user.

  Here is a review of the bashscript.

  ![Review of bashscript](/00-docs/content/images/combineSeq-01.png)

- A command prompt such as the one below will be prompted.

  ![command prompt pic](/link-of-the-pic)

## Outputs

- After running the scripts, the outputs will be produced. This can be found inside the **output** folder of the **main folder**
- Expected Outputs

  - `combineSequences.fasta`
  - `combineSequences.tsv`

## Duplicate Headers 
- 
