// RNA-NextFlow
// Best Practice Guidelines: https://nf-co.re/docs/contributing/modules

include { SUMMARISE } from './workflows/summarise'
include { FILTER } from './workflows/filter'
include { PLOT_STATS } from './workflows/plot_stats'
include { BURDEN } from './workflows/burden'
include { PLINK_CONVERT } from './modules/plink_convert'
include { FIX_PHENO } from './modules/fix_pheno'
include { PLINK_UPDATE_PHENO } from './modules/plink_update_pheno'

workflow {
  // Validate mandatory parameters
  params.each{ k, v -> if (v==null) { exit 1, "Error: parameter '$k' not set." } }
  
  // Get PLINK format files - read as [ variants, [ variants.bed, variants.bim, variants.fam ] ]
  basename = Channel.fromPath( params.plink )
  
  // Recode to PLINK binary format if required
  if (!params.binary_format) {
    plink = Channel
      .fromPath( "${params.plink}.{ped,map}" )
      .collect()
      .map{ check_size(it, 2) }
      .map{ [it[0].simpleName, it ] }
    PLINK_CONVERT(plink) 
    plink = PLINK_CONVERT.out
  } else {
    plink = Channel
      .fromPath( "${params.plink}.{bed,bim,fam}" )
      .collect()
      .map{ check_size(it, 3) }
      .map{ [it[0].simpleName, it ] }
  }

  // Update phenotype if required
  if (params.pheno_file) {
    pheno = Channel
      .fromPath(params.pheno_file)
      .ifEmpty { exit 1, "ERROR: Cannot find file: ${params.pheno_file}" }
    if (params.pheno_name == '' ) {
      exit 1, "ERROR: No pheno name provided for: ${pheno_file}"
    }
    FIX_PHENO(pheno)
    PLINK_UPDATE_PHENO(plink, FIX_PHENO.out, params.pheno_name)
    plink = PLINK_UPDATE_PHENO.out
  }

  SUMMARISE(plink)

  FILTER(
    plink,
    params.missing_geno,
    params.missing_indi,
    params.maf,
    params.hwe_control,
    params.hwe_case,
    params.het_sd,
    params.pihat
  )

  PLOT_STATS(
    SUMMARISE.out.imiss,
    SUMMARISE.out.lmiss,
    SUMMARISE.out.hwe,
    SUMMARISE.out.maf,
    FILTER.out.heterozygosity,
    params.het_sd
  )

  gff3 = Channel
    .fromPath(params.gff3)
    .ifEmpty { exit 1, "ERROR: Cannot find file: ${params.gff3}" }
  BURDEN(
    FILTER.out.plink,
    gff3,
    params.key,
    params.covar_file,
    params.covar_name
  )
}


def check_size(List samples, n) {
  if (samples.size() != n) {
    exit 1, "ERROR: Expected ${n} PLINK files."
  }
  return samples
}