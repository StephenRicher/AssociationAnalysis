/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Aggregate and summarise variants filtering steps
----------------------------------------------------------------------------------------
*/

process FILTER_SUMMARY {
    input:
    path 'qc?.log'

    output:
    path '*.csv'

    script:
    """
    #!/usr/bin/env python

    import glob
    import pandas as pd
    from collections import defaultdict

    logs = sorted(glob.glob('qc*.log'))
    data = defaultdict(list)
    for i, log in enumerate(logs):
        with open(log) as fh:
            for line in fh:
                line = line.strip()
                fields = line.split()
                if len(fields) < 3:
                    continue
                elif fields[1] == 'variants':
                    if fields[2] == 'loaded':
                        data[('loaded', 'variants')].append(int(fields[0]))
                elif fields[1] == 'people':
                    if fields[2] != 'removed':
                        data[('loaded', 'people')].append(int(fields[0]))
                        males = int(fields[2].strip('('))
                        data[('loaded', 'male')].append(males)
                        data[('loaded', 'female')].append(int(fields[4]))
                        data[('loaded', 'amiguous')].append(int(fields[6]))
                elif fields[1] == 'phenotype':
                    data[('loaded', 'phenotype')].append(int(fields[0]))
                if line.endswith('pass filters and QC.'):
                    data[('retain', 'variants')].append(int(fields[0]))
                    data[('retain', 'people')].append(int(fields[3]))

    data = pd.DataFrame(data)
    data[('removed', 'variants')] = (
        data[('loaded', 'variants')] - data[('retain', 'variants')])
    data[('removed', 'people')] = (
        data[('loaded', 'people')] - data[('retain', 'people')])
    data.columns = pd.MultiIndex.from_tuples(data.columns)

    data.index = ([
        'missing_geno', 'missing_individual', 
        'low_maf', 'hwe_control', 'hwe_case', 
        'heterozygosity', 'relatedness'
    ])
    data.to_csv('filter-summary.csv')
    """
}