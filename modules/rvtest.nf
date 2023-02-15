process RVTEST {
    input:
    tuple val(prefix), path(plink)
    tuple val(prefix), path(vcf)
    tuple val(prefix), path(vcf_idx)
    path setFile
    path covar
    val covar_name

    output:
    tuple val(prefix), path('*.assoc')

    script:
    def args = covar.name != 'NO_FILE' ? "--covar $covar --covar-name ${covar_name.join(',')}" : ''
    """
    rvtest --noweb $args \
        --inVcf $vcf --setFile $setFile --out output \
        --pheno ${prefix}.fam \
        --burden cmc --kernel skat 
    """
}

