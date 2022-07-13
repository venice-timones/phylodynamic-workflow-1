# Align Sequences

## Table of contents

- [Overview](#overview)
- [Input](#input)
- [Scripts](#scripts)
- [Output](#output)

## Overview

- After quality checking the samples, we are going to fix the alingment of the sequences.

- By opening the sequences using **AliView**, an alignment viewer software, we can see nucleotides that are unaligned.

  ![picture of the unaligned sequence](/00-docs/content/images/03-duplicate-04.png)

- After performing this process, the sequences should be similar with the image provided below.

  ![picture of the aligned sequence](/00-docs/content/images/03-duplicate-04.png)

- By aligning the sequences, the analyses and comparison of the data will be easier.

## Input

- The resulting files with the extension `.fasta` inside the **output** folder of the **04-qualityCheckSequences** folder will be used as the input here.
- Put **one** `.fasta` file **at a time** inside the **input** folder of the **06-alignSequences** folder.
  ### Expected file to input:
  - One sequence file: `.fasta`

## Scripts

- The [scripts](/06-alignSequences/) inside the `06-alignSequences` folder will be used.

  - Uses [MAFFT](https://mafft.cbrc.jp/alignment/software/) for aligning sequences, and [Nextclade]() as reference for the sequences.
  - The script first downloads updates on the reference and proceeds to filter and align the sequences.
  - Here is a review of the bash script:
    <br></br>
    ![picture of bashscript](/dasdad)

- To run the bash script:

  - Double click the file.
  - For **MacOS** users, execute the `.command` file
  - For **Windows** users, execute the `.bat` file
  - A **command prompt** will pop-up, then wait until the script is completely executed.

## Output

- A file `align.fasta` should now be found on the **output** folder of the `06-alignSequences` folder.
- Rename the output file with the corresponding input file name (e.g. **barmm-align.fasta**)
- Repeat these steps for the remaining input files. There should be a total of **6 outputs** by the end of this process.
  ### Expected Outputs:
  - `barmm-align.fasta`
  - `caraga-align.fasta`
  - `davao-align.fasta`
  - `northernmindanao-align.fasta`
  - `soccsksargen-align.fasta`
  - `zamboanga-align.fasta`
