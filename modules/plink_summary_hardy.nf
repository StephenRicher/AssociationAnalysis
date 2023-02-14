process PLINK_SUMMARY_HARDY {
    input:
    tuple val(prefix), path(data)

    output:
    path '*.hwe', emit: hardy

    script:
    """
    plink --bfile $prefix --hardy --out $prefix
    """
}