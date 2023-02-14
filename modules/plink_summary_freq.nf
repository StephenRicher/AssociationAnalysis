process PLINK_SUMMARY_FREQ {
    input:
    tuple val(prefix), path(data)

    output:
    path '*.frq', emit: freq

    script:
    """
    plink --bfile $prefix --freq --out $prefix
    """
}