# Combine Sequences To One Set

## Table of contents

- [Overview](#overview)
- [Input](#input)
- [Scripts](#scripts)
- [Output](#output)
- [Duplicated Headers](#duplicated-headers)

## Overview

- After fixing the metadata errors, we will combine all the **sequences** and **metadata files** into **one Mindanao file** each.
- This is to easily group different Regions by concatenating all the data first, and then subsampling them into individual Mindanao Regions later on.

## Input

- The resulting files with the extension `.tar` inside the **output** folder of the **01-fixMetadata** folder will be used as the input here.

- We first decompress the `.tar` files. We can find a `.fasta` and a `.tsv` file inside. Repeat for all the `.tar` files.

- Gather all the sequences and metadata files from each `.tar` files. Place them inside the **input** folder of the **02-combineSequences** folder

  ### Expected files to input:

  - `*.fasta`
  - `*.tsv`

  _Note: The \* represents any file name. The number of sequences and metadata files depends on the number of `.tar` files._

## Scripts

- The [scripts](/02-combineSequences/) inside the `02-combineSequences` folder will be used.

  - The bash script combines all sequences into one `.fasta` file.
  - It also combine all metadata file into one `.tsv` file.

  - Here is a review of the bash script.

    ![Review of bashscript](/00-docs/content/images/combineSeq-01.png)

- To run the bash script:
  - Double click the file.
  - For **MacOS** users, execute the `.command` file
  - For **Windows** users, execute the `.bat` file
  - A **command prompt** will pop-up, then wait until the script is completely executed.

## Output

- These files should now be found on the output folder of the `02-combineSequences` folder.

  ### Expected Outputs

  - `combineSequences.fasta`
  - `combineSequences.tsv`

## Duplicated Headers

- When checking out the contents of the expected outputs, multiple **Headers** may be found such as the images below. For example, the header can be found on the **1st** line and the **4849th** line of the `combineSequences.tsv` file.

  ![image1](/00-docs/content/images/03-duplicate-01.png)

  ![image1](/00-docs/content/images/03-duplicate-02.png)

- With the presence of duplicated headers, errors are bound to occur when following the next methods. Because of this, we must delete all the duplicated headers.

- Open the `combineSequences.tsv` file using a text editor applications such as **Sublime Text** and **Visual Studio Code**. Prompt the search panel by pressing **ctrl + f** on your keyboard. Type in a unique word that can be only found on the header, such as **genbank_accession**.

  ![image1](/00-docs/content/images/03-duplicate-03.png)

- As you can see on the top right of the image, after typing in a unique word, 6 results were founds. This means that there are a total of 6 headers, therefre we must remove 5 duplicated headers.

  ![image1](/00-docs/content/images/03-duplicate-04.png)

- To remove the duplicated headers (2-6), delete the row in which the header is placed. Repeat for all the remaining duplicated headers.

- Repeat the steps for the `combineSequences.fasta` file.
