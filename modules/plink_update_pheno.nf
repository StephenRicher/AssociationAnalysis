/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Update PLINK .fam file with new phenotype
------------------------------------------------------------------------------
*/

process PLINK_UPDATE_PHENO {
    input:
    tuple val(prefix), path(data, stageAs: "in/*")
    path pheno
    val pheno_name

    output:
    tuple val(prefix), path('*.{bed,bim,fam}')

    script:
    def args = task.ext.args ?: ''
    """
    plink $args \
        --bfile in/$prefix --make-bed --out $prefix \
        --recode --pheno $pheno --pheno-name $pheno_name
    """
}