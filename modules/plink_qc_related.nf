process PLINK_QC_RELATED {
    input:
    tuple val(prefix), path(data)
    val threshold

    output:
    tuple val("${prefix}-related"), path('*.{bed,bim,fam}')

    script:
    """
    plink --bfile $prefix --genome --min $threshold --make-bed --out $prefix-related
    """
}