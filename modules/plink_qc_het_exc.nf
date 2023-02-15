/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Exclude individuals with highly deviating heterozygosity
------------------------------------------------------------------------------
*/

process PLINK_QC_HET_EXC {
    input:
    tuple val(prefix), path(data, stageAs: "in/*")
    tuple val(prefix), path(exclude)

    output:
    tuple val(prefix), path('*.{bed,bim,fam}'), emit: plink
    path '*.log', emit: log

    script:
    """
    plink --bfile in/$prefix --make-bed --out $prefix --remove $exclude 
    """
}