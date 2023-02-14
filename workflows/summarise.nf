
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Subworkflow for summary of PLINK input
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { PLINK_SUMMARY_MISSING } from '../modules/plink_summary_missing'
include { PLINK_SUMMARY_HARDY } from '../modules/plink_summary_hardy'
include { PLINK_SUMMARY_FREQ } from '../modules/plink_summary_freq'

workflow SUMMARISE {
  take:
  plink

  main:
  PLINK_SUMMARY_MISSING(plink)
  PLINK_SUMMARY_HARDY(plink)
  PLINK_SUMMARY_FREQ(plink)

  emit:
  imiss = PLINK_SUMMARY_MISSING.out.imiss
  lmiss = PLINK_SUMMARY_MISSING.out.lmiss
  hardy = PLINK_SUMMARY_HARDY.out.hardy
  freq = PLINK_SUMMARY_FREQ.out.freq
}