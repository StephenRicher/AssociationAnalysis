/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Standardise pheno file for PLINK 1.9/2 compatability
    - Add FID column (if absent) and set to 0
    - Standardise columns names to FID / IID
----------------------------------------------------------------------------------------
*/

process FIX_PHENO {
    input:
    path pheno, stageAs: 'traits-raw.phe'

    output:
    path 'traits.phe'

    script:
    """
    #!/usr/bin/env python

    import pandas as pd

    pheno = pd.read_csv('${pheno}', sep='\\s+')
    col1 = pheno.columns[0]
    if col1.lstrip('#').upper() == 'FID':
        pheno = pheno.rename(columns = {col1: 'FID'})
        pheno['FID'] = 0
    else:
        pheno.insert(0, 'FID', 0)
    iid = pheno.columns[1]
    pheno = pheno.rename(columns = {iid: 'IID'})
    pheno.to_csv('traits.phe', index=False, sep='\\t')
    """
}