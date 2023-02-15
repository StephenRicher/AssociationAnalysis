
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Subworkflow for Burden Test with RVTEST
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { GFF3_TO_EXON_SET } from '../modules/gff3_to_exon_set'
include { PLINK_TO_VCF } from '../modules/plink_to_vcf'
include { INDEX_VCF } from '../modules/index_vcf'
include { FIX_PHENO } from '../modules/fix_pheno'
include { MAKE_COVAR } from '../modules/make_covar'
include { RVTEST_SKAT } from '../modules/rvtest_skat'
include { RVTEST_CMC } from '../modules/rvtest_cmc'

workflow BURDEN {
  take:
  plink
  gff3
  key
  covar_file
  covar_name

  main:
  GFF3_TO_EXON_SET(gff3, key)
  PLINK_TO_VCF(plink)
  INDEX_VCF(PLINK_TO_VCF.out)

  if (covar_file != 'NO_FILE') {
    covar_file = Channel
      .fromPath(covar_file)
      .ifEmpty { exit 1, "ERROR: Cannot find file: ${covar_file}" }
    if (!covar_name) {
      exit 1, "ERROR: covar_name not set."
    }
    FIX_PHENO(covar_file)
    MAKE_COVAR(plink, FIX_PHENO.out, covar_name)
    covar_file = MAKE_COVAR.out
  } else {
    covar_file = file(covar_file)
  }
  RVTEST_SKAT(
    plink,
    PLINK_TO_VCF.out,
    INDEX_VCF.out,
    GFF3_TO_EXON_SET.out,
    covar_file,
    covar_name
  )
  RVTEST_CMC(
    plink,
    PLINK_TO_VCF.out,
    INDEX_VCF.out,
    GFF3_TO_EXON_SET.out,
  )
}