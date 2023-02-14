process PLINK_TO_VCF {
    input:
    tuple val(prefix), path(data)

    output:
    tuple val(prefix), path('*.vcf')

    script:
    """
    plink --bfile $prefix --recode vcf --out $prefix
    """
}