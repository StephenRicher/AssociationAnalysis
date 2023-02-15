/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Standardise covar file for RVTEST compatability
------------------------------------------------------------------------------
*/

process INDEX_VCF {
    input:
    tuple val(prefix), path(vcf)

    output:
    tuple val(prefix), path('*.tbi')

    script:
    """
    tabix $vcf
    """
}