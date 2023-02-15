/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Scatter plot of invidual missingness by heterozygosity
----------------------------------------------------------------------------------------
*/

process PLOT_MIND_HET {
    input:
    tuple val(prefix), path(het)
    path imiss
    val het_sd

    output:
    path('*.pdf')

    script:
    """
    #!/usr/bin/env python

    import pandas as pd
    import seaborn as sns
    import matplotlib.pyplot as plt

    het = pd.read_csv('${het}', sep='\\s+')
    max_sd = ${het_sd}
    col = f'|SD| > {max_sd}'
    het[col] = het['HET_DST'].abs() > max_sd
    imiss = pd.read_csv('${imiss}', sep='\\s+')

    data = pd.merge(het, imiss, left_on='IID', right_on='IID')

    fig, ax = plt.subplots()
    sns.scatterplot(data=data, x='F_MISS', y='HET_RATE', hue=col)
    ax.set_xlabel('Proportion of missing genotypes per individual')
    ax.set_ylabel('Heterozygosity rate per individual')
    fig.tight_layout()
    fig.savefig('MindHet.pdf')
    """
}