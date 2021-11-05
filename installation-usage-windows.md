# Preprocessing Script - Guide in Windows Operating System (OS)

<i>Imari Joy C. Borda</i>

This script automatically does the following:

1. Subsamples the Mindanao region sequences (BARMM, Davao, North Mindanao, CARAGA, Zamboanga, Soccsksargen) from the Philippine sequences.
2. Removes the sequences that do not pass the Nextstrain QC from the fasta and metadata files.
3. Graphs the collection date per region by gender and by Pangolin Lineage (only includes the clean sequences).

Note: Internet connectivity is needed in running the script.



## Set up the environment

These processes sets up the environment and downloads the necessary scripts. This will only be done once.

### Set up the Windows Subsytem for Linux (WSL)

This is needed because some scripts can only be run in Mac or Linux OS. 

1. Navigate to `control panel` then to `Turn Windows features on or off`.
2. Check `Windows Subsytem for Linux` and restart computer.
3. Verify installation by entering `bash` in the command line.
4. Download `Ubuntu` from `Microsoft Store`.
5. Open `Ubuntu` and enter `username` and `password`.


### Set up the Nextstrain Environment

1. Go to `https://docs.conda.io/en/latest/miniconda.html` (choose the linux version) and download Miniconda. Put this on the downloads directory.

2. In the `Ubuntu` command line, navigate to the downloads directory. Note: change `ijbor` to your username.

   ```bash
   ln -s /mnt/c/Users/ijbor ~/win-home
   cd win-home
   cd Downloads
   ```

3. Install Miniconda. 

   ```bash
   bash Miniconda3-lastest-Linux-x86_64.sh
   ```

   Follow the installation process. Enter "yes" or "accept" accordingly. After installation, close and reopen `Ubuntu`.

4. Update `conda` and install `mamba`. 

   ```bash
   conda update -n base conda
   conda install -n base -c conda-forge mamba
   ```

   Note: If an error persist such as `HTTP 000 CONNECTOION FAILED`, restart `wsl` by closing `Ubuntu` and entering the following command in `powershell`: `wsl --shutdown` . Restart `Ubuntu`.

5. Create nextsrain environment.

   ```bash
   mamba create -n nextstrain -c conda-forge -c bioconda \
     augur auspice nextstrain-cli nextalign snakemake awscli git pip
   ```

6. Verify installation. 

   ```bash
   conda activate nextstrain
   nextstrain check-setup --set-default
   ```

   The final line of the output should look like this.

   ```bash
   Setting default environment to native.
   ```

7. Update nextstrain environment.

   ```bash
   mamba update -n base conda mamba
   conda activate nextstrain
   mamba update --all -c conda-forge -c bioconda
   ```

### Download SARS-CoV-2 Workflow

1. Close and reopen `Ubuntu`. Navigate first to `/win-home/` (or your username) before executing the command.

   ```bash
   cd win-home
   ```

2. Download the directories from Git. A folder `ncov` should now be in your `/ijbor/` (or your username) directory.

   ```bash
   git clone https://github.com/nextstrain/ncov.git
   cd ncov
   ```

### Download Nextclade
1. Download the latest version of nextclade executable file. Ensure that the downloaded file has file name `nextclade`.

   ```shell
   cd win-home
   cd Downloads
   curl -fsSL "https://github.com/nextstrain/nextclade/releases/latest/download/nextclade-Linux-x86_64" -o "nextclade" && chmod +x nextclade
   ```

2. Navigate to the one of the `Path` directories

   ```shell
   echo $PATH
   ```

   Navigate to the first path directory. Usually it is the `miniconda3/envs/packages/bin`. Restart the `Ubuntu`.

   ```shell
   cd miniconda3
   cd envs
   cd packages
   cd bin
   ```

   Open the current directory in the file expolered.

   ```shell
   explorer.exe .
   ```
   
3. Save the `nextclade` file to the newly opened file explorer window.

4. Give access to the executable file to run by typing the following command. Ensure that you are still in the `miniconda3/envs/packages/bin` directory when executing the command.

   ```shell
   chmod u+x nextclade
   ```

5. Ensure that the executable file was properly set-up. 

   ```shell
   nextclade -v
   ```

   The result should be `1.4.4` (or the lastest current version number).

### Download R

1. Close and reopen `Ubuntu`. Download R directly from `Ubuntu`. This installation may take some time.

   ```bash
   sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/debian wheezy-cran3/" >> /etc/apt/sources.list'
   
   sudo apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480
   
   sudo apt-get update
   
   sudo apt-get install r-base
   ```

### Transfer scripts to designated folders

* `filter.R` to `ncov/scripts/` directory.
* `graph.R` to `ncov/scripts/` directory.
* `preprocess.sh` in the same folder as the `ncov-master` (or `ncov`) directory. 
* The folder `sars-cov-2` inside the `data/` folder.

### Install R-packages

1. Close and reopen `Ubuntu`. Run the following commands.

   ```bash
   sudo su - -c "R -e \"install.packages('pacman')\""
   sudo su - -c "R -e \"install.packages('ggplot2')\""
   sudo su - -c "R -e \"install.packages('lubridate')\""
   sudo su - -c "R -e \"install.packages('scales')\""
   sudo su - -c "R -e \"install.packages('stringr')\""
   ```

   Enter password when prompted. This may take some time. 

### Modify the R script working directories

* In `filter.R`:

  * change line 5 to: `setwd("/mnt/c/Users/ijbor/ncov")`

* In `graph.R`:

  * change line 5 to: `setwd("/mnt/c/Users/ijbor/ncov")`

  Note: change `ijbor` to your username.

### Make folders for outputs

* Make folder `preprocess` inside the `ncov/` directory.

* Make folder `result` inside the `ncov/preprocess/` directory

  

## Execute the Preprocesing Script

### Download sequences and metadata from GISAID

* Download philippine sequences in two batches (because GISAID limits download to a maximum of 5000 sequences at a time). Unzip the tar files and use the following naming conventions. Change the date (yyyymmdd) and batch number accordingly. The date corresponds to the day the sequences were downloaded. Example: 21 October 2021 is 211021.
  * sequences: `211021.batch1.sequences.fasta`
  * metadata: `211021.batch1.metadata.tsv`

* Save the download sequences in the `ncov-master/preprocess` directory.

### Prepare the preprocess script

* Change the first line of the `preprocess.sh` script to indicate the correct date (see line 4). Right click on the file and open with a text-editor (ex: notepad).

  ```bash
  declare -r date=211021 
  ```


### Run the script

* Open the `Ubuntu` console, navigate to the `win-home` folder.

  ```bash
  cd win-home
  ```

* Run the script by entering the following command.

  ```bash
  bash preprocess.sh
  ```

  Wait for the process to end.



## Locate the outputs

All the outputs are stored in the `ncov-master/preprocess/` directory. See text below for the details of each file. The dates may differ (I used 211024).

#### Under the `ncov-master/preprocess` folder:

* sequences: `211024.batch1.sequences.fasta` - batch1 of the sequences downloaded from GISAID

  metadata: `211024.batch1.metadata.tsv`- batch1 of the metadata downloaded from GISAID

* sequences: `211024.batch1.sequences.fasta` - batch2 of the sequences downloaded from GISAID

  metadata: `211024.batch1.metadata.tsv` - batch2 of the metadata downloaded from GISAID

* sequences: `211024.ph.sequences.fasta` - combination of batch1 and batch2 of sequences (philippine sequences)

  metadata: `211024.ph.metadata.tsv` - combination of batch1 and batch2 of metadata (philippine sequences)

* sequences: `211024.ph.sequences.sanitized.fasta` - philippine sequences but the prefix `"hCoV-19/"` removed

  metadata: `211024.ph.metadata.sanitized.tsv` - philippine metadata but the prefix `"hCoV-19/"` removed

* index file: `211024.ph.index.sanitized.tsv` - philippine metadata count of bases (A, C, T, G)

* filter file: `211024.davao.filter.txt` - list of sequences from the phillipine data that are from davao region

* sequences: `211024.davao.sequences.sanitized.fasta` - davao sequences and the prefix `"hCoV-19/"` removed

  metadata: `211024.davao.metadata.sanitized.tsv` - davao metadata and the prefix `"hCoV-19/"` removed

* QC result: `211024.davao.qc.result.tsv` - davao QC result

* filter file: `211024.davao.filter.clean.txt` - list of sequences from the davao region that passed the QC check

#### Under the `ncov-master/preprocess/result` folder:
* sequences: `211024.davao.sequences.sanitized.clean.fasta` - davao sequences and the prefix `"hCoV-19/"` removed and passed the QC

  metadata: `211024.davao.metadata.sanitized.clean.tsv` - davao metadata and the prefix `"hCoV-19/"` removed and passed the QC

* graph: `211024.mindanao.collection.date.png` - graph of collection date timeseries of mindanao (by regions) clean samples

* graph: `211024.mindanao.gender.png` - graph of collection date timeseries of mindanao (by regions) clean samples by gender

* graph: `211024.mindanao.pangolin.lineage.png` - graph of collection date timeseries of mindanao (by regions) clean samples by pangolin lineage

Note: The outputs with `davao` in the filename were repeated for each region.



