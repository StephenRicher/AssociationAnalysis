process RVTEST_CMC {
    input:
    tuple val(prefix), path(plink)
    tuple val(prefix), path(vcf)
    tuple val(prefix), path(vcf_idx)
    path setFile

    output:
    tuple val(prefix), path('*.assoc')

    script:
    """
    rvtest \
        --inVcf $vcf --out $prefix --noweb \
        --setFile $setFile --pheno ${prefix}.fam \
        --burden cmc 
    """
}
