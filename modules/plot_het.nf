process PLOT_HET {
    input:
    tuple val(prefix), path(data)

    output:
    path('*.pdf')

    script:
    """
    #!/usr/bin/env python

    import pandas as pd
    import seaborn as sns
    import matplotlib.pyplot as plt

    het = pd.read_csv('${data}', sep=' ')
    fig, ax = plt.subplots()
    sns.histplot(het['HET_DST'], stat='density', ax=ax)
    ax.set_xlabel('Heterozygosity Rate')
    ax.set_ylabel('Density')
    ax.set_title('Heterozygosity Rate')
    fig.tight_layout()
    fig.savefig('HeterozygosityRate.pdf')
    """
}