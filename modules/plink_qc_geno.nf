process PLINK_QC_GENO {
    input:
    tuple val(prefix), path(data)
    val threshold

    output:
    tuple val("${prefix}-geno"), path('*.{bed,bim,fam}')

    script:
    """
    plink --bfile $prefix --geno $threshold --make-bed --out $prefix-geno
    """
}