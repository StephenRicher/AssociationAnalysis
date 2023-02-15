# Association Analysis - Nextflow

## A Nextflow pipeline for performing rare variant association analysis using [rvtests](https://github.com/zhanxw/rvtests).


## Table of contents
  * [Introduction](#introduction)
  * [Quick Start](#quick-start)
  * [Pipeline Summary](#pipeline-summary)
  * [Configuration](#configuration)
  * [References](#references)


## Introduction
This experimental Nextflow pipeline conducts rare variant association analysis for binary outcome measures using [rvtests](https://github.com/zhanxw/rvtests).
The workflow also conducts automated QC filtering and visualisation.

## Quick Start

1. Install [`Nextflow`](https://www.nextflow.io/docs/latest/getstarted.html#installation) (`>=22.10.1`)

2. Install [`Docker`](https://docs.docker.com/engine/installation/) for full pipeline reproducibility.

3. Download the pipeline and the test data.

    ```bash
    git clone https://github.com/StephenRicher/AssociationAnalysis
    ```

4. Test the pipeline using the [example data](./data/) with a single command:

   ```bash
   nextflow run main.nf -profile docker
   ```

   The pipeline includes an example [dataset](./data/) and pre-configured [configuration file]('./nextflow.config') with reasonable default parameters for testing.

   > - The pipeline includes a config profile called `docker`, which instruct the pipeline to utilise containers for processes management.

## Pipeline Summary
The pipeline comprises four key sub-workflows:

### summarise()
The `summarise()` workflow generate summary statistics for the input data.

* Missingness per SNP and individual
* Minor Allele Frequency (MAF)
* Hardy-Weinberg equilibrium (HWE)

### filter()
The `filter()` workflow conduct typical QC filtering. All filtering statistics, including an [aggregated report]('./results/summary/filter-summary.csv'), are written to the [output directory]('./results/summary/')

* Filter SNPs with high missingness
* Filter individuals with high missingness
* Filter SNPS with low Minor Allele Frequency (MAF)
* Filter SNPS not in Hardy-Weinberg equilibrium (HWE)
   * Case and control filtered independently.
* Filter SNPS with low MAF
* Filter individuals with highly deviating heterozygosity
* Filter individuals by relatedness (pi‐hat threshold)

### plot_stats()
The `plot_stats()` workflow generates visual summaries of the input data. Plots are saved to the [output directory]('./results/summary/plots').

### association()
The `association()` workflow conducts a CMV burden test and a SKAT test with optional covariates. A setFile is automatically generated from the user-provided GFF3 file. Grouping units are defined by genes (exonic regions only).  

## Configuration
See below and [here]('./conf/defaults.config') for default parameters with descriptions. Users should set parameters in the main [configuration file]('./nextflow.config').

```
// Default parameters - mandatory set to null

params {
    plink          = null          // Prefix to PLINK format
    binary_format  = null          // Set True if input is PLINK binary
    outdir         = './results/'  // Path to output directory.

    // QC Thresholds
    missing_geno = 0.2   // Exclude genotype with high missing rate
    missing_indi = 0.2   // Exclude individual with higher missing genotyping rate
    maf          = 0.05  // Exclude SNPs below minor allele frequency threshold
    hwe_control  = 1e-6  // Exclude markers deviating from Hardy–Weinberg equilibrium (control sample)
    hwe_case     = 1e-10 // Exclude markers deviating from Hardy–Weinberg equilibrium (case sample)
    related      = 0.2   // Exclude individuals by relatedness
    het_sd       = 3     // Remove individuals who deviate beyond heterozygosity rate mean

    // Genes of Interest
    gff3         = null      // Genes of interest in .gff3 format
    key          = 'gene_id' // Gene attribute key to label sets

    // Covariate
    covar_file   = 'NO_FILE' // Path to covar file
    covar_name   = ''        // List of columns names indiciating covariates (e.g. ['covar1', 'covar2'])

    // Phenotype
    pheno_file   = ''        // Path to pheno file
    pheno_name   = ''        // Column name of phenotype
    zero_one     = false     // Set true if phenotype is encoded as '0' = control and '1' = case
}   
```

## References
- Marees, A.T., de Kluiver, H., Stringer, S., Vorspan, F., Curis, E., Marie-Claire, C. and Derks, E.M., 2018. A tutorial on conducting genome-wide association studies: Quality control and statistical analysis. International Journal of Methods in Psychiatric Research [Online], 27(2). Available from: https://doi.org/10.1002/mpr.1608.
- Purcell, S., Neale, B., Todd-Brown, K., Thomas, L., Ferreira, M.A.R., Bender, D., Maller, J., Sklar, P., De Bakker, P.I.W., Daly, M.J. and Sham, P.C., 2007. PLINK: A tool set for whole-genome association and population-based linkage analyses. American Journal of Human Genetics [Online], 81(3). Available from: https://doi.org/10.1086/519795.
- Zhan, X., Hu, Y., Li, B., Abecasis, G.R. and Liu, D.J., 2016. RVTESTS: An efficient and comprehensive tool for rare variant association analysis using sequence data. Bioinformatics [Online], 32(9). Available from: https://doi.org/10.1093/bioinformatics/btw079.
