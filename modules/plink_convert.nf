process PLINK_CONVERT {
    input:
    tuple val(prefix), path(data, stageAs: "in/*")

    output:
    tuple val(prefix), path('*.{bed,bim,fam}')

    script:
    """
    plink --file in/$prefix --make-bed --out $prefix
    """
}