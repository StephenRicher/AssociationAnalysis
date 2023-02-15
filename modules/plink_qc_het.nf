/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Assess individual heterozygosity
------------------------------------------------------------------------------
*/

process PLINK_QC_HET {
    input:
    tuple val(prefix), path(data)

    output:
    tuple val(prefix), path('*.het')

    script:
    """
    plink --bfile $prefix --out $prefix --het 
    """
}