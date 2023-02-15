/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Exclude SNPS not in HWE (case samples, less stringent)
------------------------------------------------------------------------------
*/

process PLINK_QC_HWE_CASE {
    input:
    tuple val(prefix), path(data, stageAs: "in/*")
    val threshold

    output:
    tuple val(prefix), path('*.{bed,bim,fam}'), emit: plink
    path '*.log', emit: log

    script:
    """
    plink --bfile in/$prefix --make-bed --out $prefix --hwe $threshold --hwe-all 
    """
}