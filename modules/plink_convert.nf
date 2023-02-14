process PLINK_CONVERT {
    input:
    tuple val(prefix), path(data)

    output:
    tuple val(prefix), path('*.{bed,bim,fam}'), emit: plink

    script:
    """
    plink --file $prefix --make-bed --out $prefix
    """
}