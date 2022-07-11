# Subsample Sequences in Mindanao Regions

## Table of Contents

- [Overview](#overview)
- [Input and Output](#input-and-output)

## Overview

- After combining the Mindanao sequences, it becomes more convenient to subsample each region.

- Use this [script](../../05-subsampleSequencesRegion/subsampleSequencesRegion.command) from the `05-subsampleSequencesRegion` folder in the repository.

  - This script subsamples sequences into individual Mindanao regions
  - Here is a review of the script:

    ![Subsample sequences script](images/subsample-01.png)

## Input and Output

### Files for input:

- `mindanao.fasta`
- `mindanao.tsv`

### Expected output:

- Sequence files:

  - `barmm.fasta`
  - `caraga.fasta`
  - `davao.fasta`
  - `Soccsksargen.fasta`
  - `zamboanga.fasta`

- Metadata files:
  - `barmm.tsv`
  - `caraga.tsv`
  - `davao.tsv`
  - `soccsksargen.tsv`
  - `zamboanga.tsv`
