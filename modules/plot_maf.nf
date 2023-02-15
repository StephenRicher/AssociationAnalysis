/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Plot histogram of Minor Allele Frequency (MAF)
----------------------------------------------------------------------------------------
*/

process PLOT_MAF {
    input:
    path maf

    output:
    path '*.pdf'

    script:
    """
    #!/usr/bin/env python

    import pandas as pd
    import seaborn as sns
    import matplotlib.pyplot as plt

    maf = pd.read_csv('${maf}', sep='\\s+')
    fig, ax = plt.subplots()
    sns.histplot(maf['MAF'], stat='density', ax=ax)
    ax.set_xlabel('Minor Allele Frequency (MAF)')
    ax.set_ylabel('Density')
    ax.set_title('Minor Allele Frequency (MAF)')
    fig.tight_layout()
    fig.savefig('MinorAlleleFrequency.pdf')
    """
}