process PLINK_TO_VCF {
    input:
    tuple val(prefix), path(data)

    output:
    tuple val(prefix), path('*.vcf.gz')

    script:
    """
    plink --bfile $prefix --recode vcf-iid bgz --out $prefix
    """
}