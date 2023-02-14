process GET_HET_FAIL {
    input:
    tuple val(prefix), path(data)
    val threshold

    output:
    tuple val(prefix), path('*-het.txt'), emit: all
    tuple val(prefix), path('*-fail.txt'), emit: exclude

    script:
    """
    #!/usr/bin/env python

    import pandas as pd

    sd_max = float(${threshold})
    het = pd.read_csv('${data}', sep='\\s+')
    het['HET_RATE'] = (het['N(NM)'] - het['O(HOM)']) / het['N(NM)']
    het['HET_DST'] = (het['HET_RATE'] - het['HET_RATE'].mean()) / het['HET_RATE'].std()
    het_fail = het.loc[het['HET_DST'].abs() > sd_max]
    het.to_csv('${prefix}-het.txt', sep=' ', index=False)
    het_fail[['FID', 'IID']].to_csv('${prefix}-fail.txt', sep=' ', index=False)
    """
}