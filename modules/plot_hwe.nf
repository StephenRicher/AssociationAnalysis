/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Plot histogram of HWE p-values
----------------------------------------------------------------------------------------
*/

process PLOT_HWE {
    input:
    path hwe

    output:
    path '*.pdf'

    script:
    """
    #!/usr/bin/env python

    import pandas as pd
    import seaborn as sns
    import matplotlib.pyplot as plt

    hwe = pd.read_csv('${hwe}', sep='\s+')
    fig, ax = plt.subplots()
    sns.histplot(hwe['P'], stat='density', ax=ax)
    ax.set_xlabel('Hardy-Weinberg Equilibrium (p-values)')
    ax.set_ylabel('Density')
    ax.set_title('Hardy-Weinberg Equilibrium (p-values)')
    fig.tight_layout()
    fig.savefig('HWE-pvalues.pdf')
    """
}