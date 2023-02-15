process PLINK_SUMMARY_MISSING {
    input:
    tuple val(prefix), path(data)

    output:
    path '*.imiss', emit: imiss
    path '*.lmiss', emit: lmiss

    script:
    """
    plink --bfile $prefix --out $prefix --missing 
    """
}