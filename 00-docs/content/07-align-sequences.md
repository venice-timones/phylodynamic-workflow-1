# Align Sequences

## Table of contents

- [Overview](#overview)
- [Input](#input)
- [Scripts](#scripts)
- [Output](#output)

## Overview

- After quality checking the samples, we are going to fix the alingment of the sequences.

- a sentence that explains bakit pangit ito na sequence.

  ![picture of the unaligned sequence](/00-docs/content/images/03-duplicate-04.png)

- explain na ang goal is the picture below.

  ![picture of the aligned sequence](/00-docs/content/images/03-duplicate-04.png)

- By aligning the sequences, the analyses of the data will be more precise/accurate/word.

## Input

- The resulting files with the extension `.fasta` inside the **output** folder of the **04-qualityCheckSequences** folder will be used as the input here.
- Put one `.fasta` file at a time inside the **input** folder of the **06-alignSequences** folder.
  ### Expected file to input
  - `*.fasta`
  
    _Note: The \* represents any file name._

## Scripts

- The [scripts](/06-alignSequences/) inside the `06-alignSequences` folder will be used.

  - purpose ng script
  - smth about mafft
  - references ng nextclade
  - Here is a review of the bash script:
    <br></br>
    ![picture in here](/dasdad)

- To run the bash script:

  - Double click the file.
  - For **MacOS** users, execute the `.command` file
  - For **Windows** users, execute the `.bat` file
  - A **command prompt** will pop-up, then wait until the script is completely executed.

## Output

- A file `align.fasta` should now be found on the **output** folder of the `06-alignSequences` folder.
- Rename the output file with the corresponding input file name (e.g. **barmm-align.fasta**)
- Repeat these steps for the remaining input files. There should be a total of 6 outputs by the end of this process.
  ### Expected Outputs
  - `barmm-align.fasta`
  - `caraga-align.fasta`
  - `davao-align.fasta`
  - `northernmindanao-align.fasta`
  - `soccsksargen-align.fasta`
  - `zamboanga-align.fasta`
