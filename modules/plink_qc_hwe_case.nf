process PLINK_QC_HWE_CASE {
    input:
    tuple val(prefix), path(data)
    val threshold

    output:
    tuple val("${prefix}-hwe_case"), path('*.{bed,bim,fam}')

    script:
    """
    plink --bfile $prefix --hwe $threshold --hwe-all --make-bed --out $prefix-hwe_case
    """
}