/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Convert GFF3 to setFile of gene groupings (exonic regions only)
------------------------------------------------------------------------------
*/

process GFF3_TO_EXON_SET {
    input:
    path gff3
    val key

    output:
    path 'exons.set'

    script:
    """
    #!/usr/bin/env python

    from collections import defaultdict

    set_list = defaultdict(list)
    with open("${gff3}") as fh:
        for line in fh:
            if line.startswith('#'):
                continue
            line = line.strip().split()
            if line[2] != 'exon':
                continue
            region = f'{line[0]}:{line[3]}-{line[4]}'
            attrs = dict(x.split('=') for x in line[8].split(';'))
            set_list[attrs["${key}"]].append(region)

    with open('exons.set', 'w') as fh:
        for key, regions in set_list.items():
            print(key, ','.join(regions), file=fh)
    """
}