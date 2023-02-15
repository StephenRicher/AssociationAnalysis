# Association Analysis - Nextflow

## A Nextflow pipeline for performing rare variant association analysis using rvtests.


## Table of contents
  * [Introduction](#introduction)
  * [Pipeline Summary](#pipeline-summary)
  * [Quick Start](#quick-start)
  * [Configuration](#configuration)
  * [References](#references)

## Introduction
binary outcome measure

## Pipeline Summary
The pipeline comprises four key sub-workflows:

### summarise()
The `summarise()` workflow generate summary statistics

## Quick Start

1. Install [`Nextflow`](https://www.nextflow.io/docs/latest/getstarted.html#installation) (`>=22.10.1`)

2. Install [`Docker`](https://docs.docker.com/engine/installation/) for full pipeline reproducibility.

3. Download the pipeline and the test data.

    ```bash
    git clone https://github.com/StephenRicher/AssociationAnalysis
    ```

3. Test the pipeline using the [example data](./data/) with a single command:

   ```bash
   nextflow run main.nf -profile docker
   ```

   The pipeline includes an example [dataset](./data/) and preconfigured [configuration file]('./nextflow.config') with reasonable default parameters for testing.

   > - The pipeline includes a config profile called `docker`, which instruct the pipeline to utilise containers for processes management.


## References
- Marees, A.T., de Kluiver, H., Stringer, S., Vorspan, F., Curis, E., Marie-Claire, C. and Derks, E.M., 2018. A tutorial on conducting genome-wide association studies: Quality control and statistical analysis. International Journal of Methods in Psychiatric Research [Online], 27(2). Available from: https://doi.org/10.1002/mpr.1608.
- Purcell, S., Neale, B., Todd-Brown, K., Thomas, L., Ferreira, M.A.R., Bender, D., Maller, J., Sklar, P., De Bakker, P.I.W., Daly, M.J. and Sham, P.C., 2007. PLINK: A tool set for whole-genome association and population-based linkage analyses. American Journal of Human Genetics [Online], 81(3). Available from: https://doi.org/10.1086/519795.
- Zhan, X., Hu, Y., Li, B., Abecasis, G.R. and Liu, D.J., 2016. RVTESTS: An efficient and comprehensive tool for rare variant association analysis using sequence data. Bioinformatics [Online], 32(9). Available from: https://doi.org/10.1093/bioinformatics/btw079.
