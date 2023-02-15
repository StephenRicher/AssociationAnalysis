/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Plot histograms of missingness per SNP and individual
------------------------------------------------------------------------------
*/

process PLOT_MISSING {
    input:
    path imiss
    path lmiss

    output:
    path 'imiss.pdf'
    path 'lmiss.pdf'

    script:
    """
    #!/usr/bin/env python

    import pandas as pd
    import seaborn as sns
    import matplotlib.pyplot as plt

    imiss = pd.read_csv('${imiss}', sep='\\s+')
    fig, ax = plt.subplots()
    sns.histplot(imiss['F_MISS'], stat='density', ax=ax)
    ax.set_xlabel('Individual Missingness')
    ax.set_ylabel('Density')
    ax.set_title('Individual Missingness')
    fig.tight_layout()
    fig.savefig('imiss.pdf')

    lmiss = pd.read_csv('${lmiss}', sep='\\s+')
    fig, ax = plt.subplots()
    sns.histplot(imiss['F_MISS'], stat='density', ax=ax)
    ax.set_xlabel('SNP Missingness')
    ax.set_ylabel('Density')
    ax.set_title('SNP Missingness')
    fig.tight_layout()
    fig.savefig('lmiss.pdf')
    """
}