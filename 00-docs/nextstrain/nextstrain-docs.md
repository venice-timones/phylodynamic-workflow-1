# Table of Contents

## Nextstrain Installation (Windows)

1. Set up the Windows Subsytem for Linux (WSL)

   1. Navigate to `control panel` then to `Turn Windows features on or off`.
   2. Check `Windows Subsytem for Linux` and restart computer.
   3. Open your `Command Prompt`. Verify installation by running the following command in the command line:
      ```
      bash
      ```
      The first line of the response should be similar to the following:
      ```
      Windows Subsytem for Linux has no installed distributions.
      ```
   4. Download [`Ubuntu`](https://apps.microsoft.com/store/detail/ubuntu/9PDXGNCFSCZV) from Microsoft Store.
   5. Open `Ubuntu` and enter `username` and `password`. Do not forget your password.
   6. Restart `Ubuntu`.

2. Install Miniconda

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

   The final output from the last command should look like this, where <option> is the option chosen in the previous step:

   ```
   Setting default environment to <option>.
   ```

7. Update `nextstrain` components.

   ```
   mamba update -n base conda mamba
   conda activate nextstrain
   mamba update --all -c conda-forge -c bioconda
   ```

8. Download ncov workflow.

   ```
   git clone https://github.com/nextstrain/ncov.git
   ```

## Nextsrain Installation (macOS)
