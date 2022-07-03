# Table of Contents

## Nextstrain Installation (Windows)

1. Set up the Windows Subsytem for Linux (WSL)

   1. Navigate to `control panel` then to `Turn Windows features on or off`.
   2. Check both `Virtual Machine Platform` and `Windows Subsytem for Linux`, then restart computer.
   3. Download and install the Linux kernel update package given in the link [here](https://docs.microsoft.com/en-us/windows/wsl/install-manual#step-4---download-the-linux-kernel-update-package).
   4. Set WSL 2 as your default version. Open `Command Prompt` and run the following:

      ```
      wsl --set-default-version 2
      ```

   5. Open your `Command Prompt`. Verify installation by running the following command in the command line:
      ```
      bash
      ```
      The first line of the response should be similar to the following:
      ```
      Windows Subsytem for Linux has no installed distributions.
      ```
   6. Download [`Ubuntu`](https://apps.microsoft.com/store/detail/ubuntu/9PDXGNCFSCZV) from Microsoft Store.
   7. Open `Ubuntu` and wait for installation to complete. Enter `username` and `password`. Do not forget your password.
   8. Restart `Ubuntu`.

2. Open `Ubuntu`. Install Miniconda:

   ```bash
   wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
   bash Miniconda3-latest-Linux-x86_64.sh
   # follow through installation prompts
   rm Miniconda3-latest-Linux-x86_64.sh
   ```

3. Install mamba on the `base` conda environment:

   ```bash
   conda install -n base -c conda-forge mamba --yes
   conda activate base
   ```

4. Install the `Nextstrain` components on the `nextstrain` environment.

   ```bash
   mamba create -n nextstrain \
     -c conda-forge -c bioconda \
     nextstrain-cli augur auspice nextalign snakemake git epiweeks nextclade nextalign pangolin pangolearn \
     --yes
   ```

5. Activate `nextstrain` environment.

   ```
   conda activate nextstrain
   ```

6. Confirm that the installation worked. Run the following command.

   ```
   nextstrain check-setup --set-default
   ```

   The final output from the last command should look like this, where <option> is the option chosen in the previous step (in our case, native):

   ```
   Setting default environment to <option>.
   ```

7. Update `nextstrain` components.

   ```
   mamba update -n base conda mamba
   conda activate nextstrain
   mamba update --all -c conda-forge -c bioconda
   ```

## Nextsrain Installation (macOS)

## 8. Download ncov workflow

1. Create a shortcut for windows in ubuntu. Replace `<username>` with your computer username (not the ubuntu username).

   ```
   ln -s /mnt/c/Users/<username> win-home
   ```

2. Go to windows file and chose a folder on which to download the ncov workflow. Here, I'll use the `Downloads` folder.
   ```
   cd win-home
   cd Downloads
   ```
3. Download the workflow. Run the following command then enter your `Ubunto` password when prompted.

   ```
   sudo git clone https://github.com/nextstrain/ncov.git
   ```

4. After running the commands above, there should now be an `ncov` folder. Go inside this folder.

   ```
   cd ncov
   ```

## Data preparation

1. Download data from GISAID, using the Augur Pipeline. Each file should be in `.tar` format. Do not unzip.
2. Fix the metadata (standardize regional names and drop quotes) using [01-fixMetadata](../../01-fixMetadata/README.md)

## Nextstrain fixes

1. Fix the longlat of mindanao regions. Update the longlat of BARMM to be 7.326624, 124.160278 by replacing the `lat_longs.tsv` in the `ncov/defaults` folder with [this updated tsv file](lat_longs.tsv).

   The longlats should be:

   | Region                                          | Longtitude | Latitude   | Remarks                         |
   | ----------------------------------------------- | ---------- | ---------- | ------------------------------- |
   | National Capital Region                         | 14.632748  | 121.027441 | Ok                              |
   | Cordillera Administrative Region                | 17.3597101 | 121.075253 | Ok                              |
   | Ilocos                                          | 17.2046698 | 120.470387 | Ok                              |
   | Cagayan Valley                                  | 17.677229  | 121.88903  | Ok                              |
   | Central Luzon                                   | 15.3909118 | 120.6857   | Ok                              |
   | Calabarzon                                      | 14.1638114 | 121.35366  | Ok                              |
   | Mimaropa                                        | 13.0152201 | 121.406418 | Ok                              |
   | Bicol                                           | 13.100588  | 123.523133 | Ok                              |
   | Western Visayas                                 | 10.6729594 | 122.722991 | Ok                              |
   | Central Visayas                                 | 10.264054  | 123.869396 | Ok                              |
   | Eastern Visayas                                 | 11.3278272 | 124.997556 | Ok                              |
   | Zamboanga Peninsula                             | 7.77301775 | 122.756005 | Ok                              |
   | Northern Mindanao                               | 8.40488525 | 124.687196 | Ok                              |
   | Davao Region                                    | 6.61093365 | 125.378239 | Ok                              |
   | Soccsksargen                                    | 6.6052578  | 124.489944 | Ok                              |
   | Caraga                                          | 9.2471392  | 125.855782 | Ok                              |
   | Bangsamoro Autonomous Region In Muslim Mindanao | 5.8506231  | 120.028403 | Changed to 7.326624, 124.160278 |

## Setup the run

1. Enter dataset inside `ncov/data/ph`. Create the `ph` folder inside `ncov/data/`. Each data should be in `.tar` format, downloaded from GISAID using Augur format pipeline.

2. Setup the build file. Use [sample build yaml file](builds.yaml) as boilerplate. Save this inside `ncov/my_profiles/ph` folder. Inside this build file, there are five main levels:

   1. **Inputs**  
      Input files are enumerated here. For each input, the `name`, `metadata`, and `sequences` should be defined. Since a `.tar` file was used (which already contains both the metadata and sequences), the content for `metadata` and `sequences` should be the same - which is the directory at which the data was placed.
   2. **Builds**  
      Builds are the different views of the nextstrain visualization output. In the auspice, each build is reflected in the fourth drop-down under the `Dataset`. [Example here](https://nextstrain.org/community/ijborda/dssphylo/mindanao?p=grid).  
      In the example, there are four builds: asia, global, philippines, and mindanao. In each build, the subsampling scheme and title should be defined. The subsampling scheme is a name that exists under the `subsampling` level. The title is a string that is displayed in the Auspice. Geolocations can also be optionally defined (such as `region` or `country`). They can be used during the subsampling query so that region, country, etc. are not hardcoded.
   3. **Subsampling**  
      Subsampling names defined under the `builds` level should be defined here. Each subsampling scheme can contain multiple levels (which are also a subsampling scheme on their own, and can be names arbitrarily). Resulting sequences from each of these levels are combined to have the final set of sequences to be used in the respective build. Each scheme accepts multiple parameters:
      - `group_by`: groups the sequences according to multiple metadata
      - `seq_per_group`: number of sequences per group (defined by `group_by`) to be selected
      - `query`: used to select sequences that matches the panda-like query.
      - `priorities`: gives priority to certain sequences
   4. **Files**  
      This level is used to define other configurations. These files are also saved inside `ncov/my_profiles/ph`.
      1. Description - used in the auspice visualization. [Sample description file here](my_description.md).
      2. Auspice config file - overrides the default Auspice config file, `defaults/auspice_config.json`.Sets the default geographical view and the default coloring to be in `division`. Also modified the maintainers to be AMBDABiDSS-Health with its corresponding link. [Sample auspice configuration file here](auspice-config-custom-data.json).
   5. **Traits**  
      Traits defines what metadata to perform ancestral reconstruction to.  
      Note: As of writing, nextstrain can only handle a maximum of 300 unique discrete traits.  
      Each level of the trait is the buildname, which needs two parameters: sampling bias correction and target columns for ancestral reconstruction.

3. Set up the resources to be used in the run. [Sample config file](config.yaml). This file is saved inside `ncov/my_profiles/ph`.
