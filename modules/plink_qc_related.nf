/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Filter individuals by relatedness (pi‐hat threshold)
------------------------------------------------------------------------------
*/

process PLINK_QC_RELATED {
    input:
    tuple val(prefix), path(data, stageAs: "in/*")
    val threshold

    output:
    tuple val(prefix), path('*.{bed,bim,fam}'), emit: plink
    path '*.log', emit: log

    script:
    def args = task.ext.args ?: ''
    """
    plink $args \
        --bfile in/$prefix --make-bed --out $prefix \
        --genome --min $threshold
    """
}