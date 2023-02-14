
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Subworkflow for QC Filtering of PLINK input
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { PLINK_QC_GENO } from '../modules/plink_qc_geno'
include { PLINK_QC_MIND } from '../modules/plink_qc_mind'
include { PLINK_QC_MAF } from '../modules/plink_qc_maf'
include { PLINK_QC_HWE_CONTROL } from '../modules/plink_qc_hwe_control'
include { PLINK_QC_HWE_CASE } from '../modules/plink_qc_hwe_case'
include { PLINK_QC_HET } from '../modules/plink_qc_het'
include { GET_HET_FAIL } from '../modules/get_het_fail'
include { PLOT_HET } from '../modules/plot_het'
include { PLINK_QC_HET_EXC } from '../modules/plink_qc_het_exc'
include { PLINK_QC_RELATED } from '../modules/plink_qc_related'

workflow FILTER {
  take:
  plink
  missing_geno
  missing_indi
  maf
  hwe_control
  hwe_case
  het_sd
  pihat

  main:
  PLINK_QC_GENO(
    plink, missing_geno)
  PLINK_QC_MIND(
    PLINK_QC_GENO.out, missing_indi)
  PLINK_QC_MAF(
    PLINK_QC_MIND.out, maf)
  PLINK_QC_HWE_CONTROL(
    PLINK_QC_MAF.out, hwe_control)
  PLINK_QC_HWE_CASE(
    PLINK_QC_HWE_CONTROL.out, hwe_case)
  PLINK_QC_HET(
    PLINK_QC_HWE_CASE.out)
  GET_HET_FAIL(
    PLINK_QC_HET.out, het_sd)
  PLINK_QC_HET_EXC(
    PLINK_QC_HWE_CASE.out, GET_HET_FAIL.out.exclude)
  PLINK_QC_RELATED(
    PLINK_QC_HET_EXC.out, pihat)

  PLOT_HET(GET_HET_FAIL.out.all)

  emit:
  plink = PLINK_QC_RELATED.out
}