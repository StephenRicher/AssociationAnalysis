
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Subworkflow for QC Filtering of PLINK input
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { PLINK_QC_GENO } from '../modules/plink_qc_geno'
include { PLINK_QC_MIND } from '../modules/plink_qc_mind'
include { PLINK_QC_MAF } from '../modules/plink_qc_maf'
include { PLINK_QC_HWE_CONTROL } from '../modules/plink_qc_hwe_control'
include { PLINK_QC_HWE_CASE } from '../modules/plink_qc_hwe_case'
include { PLINK_QC_HET } from '../modules/plink_qc_het'
include { GET_HET_FAIL } from '../modules/get_het_fail'
include { PLINK_QC_HET_EXC } from '../modules/plink_qc_het_exc'
include { PLINK_QC_RELATED } from '../modules/plink_qc_related'
include { FILTER_SUMMARY } from '../modules/filter_summary'

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
    PLINK_QC_GENO.out.plink, missing_indi)
  PLINK_QC_MAF(
    PLINK_QC_MIND.out.plink, maf)
  PLINK_QC_HWE_CONTROL(
    PLINK_QC_MAF.out.plink, hwe_control)
  PLINK_QC_HWE_CASE(
    PLINK_QC_HWE_CONTROL.out.plink, hwe_case)
  PLINK_QC_HET(
    PLINK_QC_HWE_CASE.out.plink)
  GET_HET_FAIL(
    PLINK_QC_HET.out, het_sd)
  PLINK_QC_HET_EXC(
    PLINK_QC_HWE_CASE.out.plink, GET_HET_FAIL.out.exclude)
  PLINK_QC_RELATED(
    PLINK_QC_HET_EXC.out.plink, pihat)

  filter_logs = Channel.of().concat( 
      PLINK_QC_GENO.out.log,
      PLINK_QC_MIND.out.log,
      PLINK_QC_MAF.out.log,
      PLINK_QC_HWE_CONTROL.out.log,
      PLINK_QC_HWE_CASE.out.log,
      PLINK_QC_HET_EXC.out.log,
      PLINK_QC_RELATED.out.log
    ).collect()
  FILTER_SUMMARY(filter_logs)

  emit:
  plink = PLINK_QC_RELATED.out.plink
  heterozygosity = GET_HET_FAIL.out.all
}