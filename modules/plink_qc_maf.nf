process PLINK_QC_MAF {
    input:
    tuple val(prefix), path(data, stageAs: "in/*")
    val threshold

    output:
    tuple val(prefix), path('*.{bed,bim,fam}'), emit: plink
    path '*.log', emit: log

    script:
    """
    plink --bfile in/$prefix --make-bed --out $prefix --maf $threshold 
    """
}