/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Update PLINK .fam file with new phenotype
----------------------------------------------------------------------------------------
*/

process PLINK_UPDATE_PHENO {
    input:
    tuple val(prefix), path(data)
    path pheno
    val pheno_name

    output:
    tuple val("${prefix}-pheno"), path('*.{bed,bim,fam}')

    script:
    def args = task.ext.args ?: ''
    """
    plink $args \
        --bfile $prefix --pheno $pheno --pheno-name $pheno_name \
        --recode --make-bed --out $prefix-pheno
    """
}