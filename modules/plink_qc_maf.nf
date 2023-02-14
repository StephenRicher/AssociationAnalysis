process PLINK_QC_MAF {
    input:
    tuple val(prefix), path(data)
    val threshold

    output:
    tuple val("${prefix}-maf"), path('*.{bed,bim,fam}')

    script:
    """
    plink --bfile $prefix --maf $threshold --make-bed --out $prefix-maf
    """
}