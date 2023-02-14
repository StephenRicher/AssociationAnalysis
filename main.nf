// RNA-NextFlow
// Best Practice Guidelines: https://nf-co.re/docs/contributing/modules

include { SUMMARISE } from './workflows/summarise'
include { PLINK_CONVERT } from './modules/plink_convert'

workflow {
  // Validate mandatory parameters
  params.each{ k, v -> if (v==null) { exit 1, "Error: parameter '$k' not set." } }
  
  // Get PLINK format files - read as [ variants, [ variants.bed, variants.bim, variants.fam ] ]
  basename = Channel.fromPath( params.plink )
  
  // Recode to binary format if required
  if (!params.binary_format) {
    plink = Channel
      .fromPath( "${params.plink}.{ped,map}" )
      .collect()
      .map{ check_size(it, 2) }
      .map{ [it[0].simpleName, it ] }
    PLINK_CONVERT(plink) 
    plink = PLINK_CONVERT.out.plink
  } else {
    plink = Channel
      .fromPath( "${params.plink}.{bed,bim,fam}" )
      .collect()
      .map{ check_size(it, 3) }
      .map{ [it[0].simpleName, it ] }
  }
  
  SUMMARISE(plink)
}


def check_size(List samples, n) {
  if (samples.size() != n) {
    exit 1, "ERROR: Expected ${n} PLINK files."
  }
  return samples
}