/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Apply Skat kernel method, optional covariates
------------------------------------------------------------------------------
*/

process RVTEST_SKAT {
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
    rvtest $args \
        --inVcf $vcf --out $prefix --noweb \
        --setFile $setFile --pheno ${prefix}.fam \
        --kernel skat 
    """
}