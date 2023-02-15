/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Generate summary statistics for variant data
------------------------------------------------------------------------------
*/

include { PLINK_SUMMARY_MISSING } from '../modules/plink_summary_missing'
include { PLINK_SUMMARY_MAF } from '../modules/plink_summary_maf'
include { PLINK_SUMMARY_HWE } from '../modules/plink_summary_hwe'

workflow SUMMARISE {
  take:
  plink

  main:
  PLINK_SUMMARY_MISSING(plink)
  PLINK_SUMMARY_MAF(plink)
  PLINK_SUMMARY_HWE(plink)

  emit:
  imiss = PLINK_SUMMARY_MISSING.out.imiss
  lmiss = PLINK_SUMMARY_MISSING.out.lmiss
  maf = PLINK_SUMMARY_MAF.out.maf
  hwe = PLINK_SUMMARY_HWE.out.hwe
}