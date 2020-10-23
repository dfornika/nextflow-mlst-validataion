#!/usr/bin/env python

import argparse
import csv
import json
import sys


def main(args):
    with open(args.ref_mlst) as mlst_json:
        ref_mlst_result = json.load(mlst_json)
    with open(args.assembled_mlst) as mlst_json:
        assembled_mlst_result = json.load(mlst_json)

    output = {}
    
    ref_mlst_scheme = None
    for key in ref_mlst_result.keys():
        ref_mlst_scheme = ref_mlst_result[key]['scheme']

    assembled_mlst_scheme = None
    for key in assembled_mlst_result.keys():
        assembled_mlst_scheme = assembled_mlst_result[key]['scheme']

    if ref_mlst_scheme == assembled_mlst_scheme:
        output['schemes_match'] = True
    else:
        output['schemes_match'] = False
    
    output_fields = [
        'schemes_match',
        # 'num_matching_alleles',
        # 'total_alleles',
        # 'proportion_alleles_matching',
    ]

    writer = csv.DictWriter(sys.stdout, fieldnames=output_fields, dialect='excel-tab')
    writer.writeheader()
    writer.writerow(output)
    

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--ref_mlst')
    parser.add_argument('--assembled_mlst')
    args = parser.parse_args()
    main(args)
