# Remove Gaps

## Table of contents

- [Overview](#overview)
- [Input](#input)
- [Scripts](#scripts)
- [Output](#output)

## Overview

- When aligning sequences, gaps such as the one below are present on the sequences. These gaps are usually located on both ends, but can also be found along the body of the sequences.

  ![pic of the gaps]()
  
- By the end of the process, the gaps will be removed from the sequences as they give no significant information to the analyses.

## Input

- The resulting files with the extension `.fasta` inside the **output** folder of the **06-alignSequences** folder will be used as the input here.
- Put **one** `.fasta` file **at a time** inside the **input** folder of the **14-removeGaps** folder.
  ### Expected files to input:
  _These files are placed one at a time._
  
  - `barmm-align.fasta`
  - `caraga-align.fasta`
  - `davao-align.fasta`
  - `northernmindanao-align.fasta`
  - `soccsksargen-align.fasta`
  - `zamboanga-align.fasta`

## Scripts

- The [scripts](/14-removeGaps/) inside the `14-removeGaps` folder will be used.

  - The script removes columns from the sequences that have atleast 10% gaps.
  - When the number of base pairs in a column is below the threshold of 0.01 or 1%, the column will be deleted.
  - Here is a review of the bash script:
    <br></br>
    ![picture of the bash script]()

- To run the bash script:

  - Double click the file.
  - For **MacOS** users, execute the `.command` file
  - For **Windows** users, execute the `.bat` file
  - A **command prompt** will pop-up, then wait until the script is completely executed.

## Output

- A file `removedGaps.fasta` should now be found on the **output** folder of the `14-removeGaps` folder.
- Rename the output file with the corresponding input file name (e.g. **barmm-removedGaps.fasta**)
- Repeat these steps for the remaining input files. There should be a total of **6 outputs** by the end of this process.
  ### Expected Outputs:
  - `barmm-removedGaps.fasta`
  - `caraga-removedGaps.fasta`
  - `davao-removedGaps.fasta`
  - `northernmindanao-removedGaps.fasta`
  - `soccsksargen-removedGaps.fasta`
  - `zamboanga-removedGaps.fasta`
