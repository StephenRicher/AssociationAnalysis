
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Subworkflow for Burden Test with RVTESTS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

include { GFF3_TO_EXON_SET } from '../modules/gff3_to_exon_set'
include { PLINK_TO_VCF } from '../modules/plink_to_vcf'
include { RVTEST } from '../modules/rvtest'

workflow BURDEN {
  take:
  plink
  gff3
  key
  pheno_file
  pheno_name
  covar_file
  covar_name



  main:
  GFF3_TO_EXON_SET(gff3, key)
  PLINK_TO_VCF(plink)
  
  RVTEST(
    PLINK_TO_VCF.out,
    GFF3_TO_EXON_SET.out,
    pheno_file,
    pheno_name,
    covar_file,
    covar_name
  )
}