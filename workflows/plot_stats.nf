
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Subworkflow for QC Filtering of PLINK input
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { PLOT_HET } from '../modules/plot_het'
include { PLOT_MAF } from '../modules/plot_maf'
include { PLOT_HWE } from '../modules/plot_hwe'
include { PLOT_MISSING } from '../modules/plot_missing'
include { PLOT_MIND_HET } from '../modules/plot_mind_het'

workflow PLOT_STATS {
  take:
  imiss
  lmiss
  hwe
  maf
  heterozygosity
  het_sd

  main:
  PLOT_HET(heterozygosity)
  PLOT_MISSING(imiss, lmiss)
  PLOT_MAF(maf)
  PLOT_HWE(hwe)
  PLOT_MIND_HET(
    heterozygosity,
    imiss,
    het_sd
  )
}