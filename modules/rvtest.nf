process RVTEST {
    input:
    tuple val(prefix), path(data)
    path setFile
    path pheno_file
    val pheno_name
    path covar_file, stageAs: 'covar'
    val covar_name

    output:
    tuple val("${prefix}-geno"), path('*.{bed,bim,fam}')

    script:
    if( covar_name == '' || covar_file == '')
        """
        rvtest \
            --inVcf $data --setFile $setFile --out output \
            --pheno $pheno_file --pheno-name $pheno_name \
            --burden cmc --kernel skat
        """
    else
        """
        rvtest \
            --covar $covar_file --covar-name ${covar_name.join(',')} \
            --inVcf $data --setFile $setFile --out output \
            --pheno $pheno_file --pheno-name $pheno_name \
            --burden cmc --kernel skat
        """
}