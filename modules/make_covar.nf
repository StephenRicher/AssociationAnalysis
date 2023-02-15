/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Standardise covar file for RVTEST compatability
------------------------------------------------------------------------------
*/

process MAKE_COVAR {
    input:
    tuple val(prefix), path(plink)
    path covar, stageAs: 'covar-raw.phe'
    val covar_name

    output:
    path 'covar.phe'

    script:
    """
    #!/usr/bin/env python

    import sys
    import pandas as pd

    covar_names = ${covar_name.collect{ '"' + it + '"'}}
    covar = pd.read_csv('${covar}', sep='\\s+')
    iid = covar.columns[1]
    covar = covar[[iid] + covar_names]

    fam_cols = ['FID', 'IID', 'fatid', 'matid', 'sex', 'phenotype']
    fam = pd.read_csv('${prefix}.fam', names=fam_cols, sep='\\s+')
    covar = pd.merge(fam, covar, left_on='IID', right_on='IID', how='left')
    covar.to_csv('covar.phe', index=False, sep='\\t')
    """
}