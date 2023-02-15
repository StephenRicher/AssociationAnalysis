process PLINK_SUMMARY_MAF {
    input:
    tuple val(prefix), path(data)

    output:
    path '*.frq', emit: maf

    script:
    """
    plink --bfile $prefix --out $prefix --freq 
    """
}