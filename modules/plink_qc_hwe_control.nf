process PLINK_QC_HWE_CONTROL {
    input:
    tuple val(prefix), path(data)
    val threshold

    output:
    tuple val("${prefix}-hwe_control"), path('*.{bed,bim,fam}')

    script:
    """
    plink --bfile $prefix --hwe $threshold --make-bed --out $prefix-hwe_control
    """
}