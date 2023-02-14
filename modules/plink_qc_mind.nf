process PLINK_QC_MIND {
    input:
    tuple val(prefix), path(data)
    val threshold

    output:
    tuple val("${prefix}-mind"), path('*.{bed,bim,fam}')

    script:
    """
    plink --bfile $prefix --mind $threshold --make-bed --out $prefix-mind
    """
}