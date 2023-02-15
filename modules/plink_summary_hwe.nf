/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Assess if SNPs are in Hardy-Weinberg equilibrium (HWE)
------------------------------------------------------------------------------
*/

process PLINK_SUMMARY_HWE {
    input:
    tuple val(prefix), path(data)

    output:
    path '*.hwe', emit: hwe

    script:
    """
    plink --bfile $prefix --out $prefix --hardy 
    """
}