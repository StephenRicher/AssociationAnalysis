process PLINK_QC_HET_EXC {
    input:
    tuple val(prefix), path(data)
    tuple val(prefix), path(exclude)

    output:
    tuple val("${prefix}-het"), path('*.{bed,bim,fam}')

    script:
    """
    plink --bfile $prefix --remove $exclude --make-bed --out $prefix-het
    """
}