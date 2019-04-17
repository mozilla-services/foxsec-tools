#!/usr/bin/env python3

import argparse
import collections
import datetime
import json
import os
import re

ruleDict = {}

def load_day_file(src_dir, day_str):

  sites_dict = {}

  with open(src_dir + '/details_json/' + day_str, 'r') as f:
    for line in f:
      line_json = json.loads(line)
      if not line_json['site'] in sites_dict:
        sites_dict[line_json['site']] = {}
      sites_dict[line_json['site']][line_json['description']] = line_json['status']

  return sites_dict

def compare_days_file(src_dir, dest_dir, day1_str, day2_str):
  day = load_day_file(src_dir, day1_str)
  prev = load_day_file(src_dir, day2_str)

  changes_file = open(dest_dir + '/changes_json/' + day2_str,'w')
  
  count = 0

  for site in day:
    if site in prev:
      for desc in day[site]:
        if desc in prev[site] and day[site][desc] != prev[site][desc]:
          record = {}
          record['day'] = day2_str
          record['prev'] = day1_str
          record['site'] = site
          record['old_status'] = prev[site][desc]
          record['new_status'] = day[site][desc]
          changes_file.write(json.dumps(record) + '\n')
          count += 1
  
  print(day1_str + " -> " + day2_str + " " + str(count) + " change(s)")

  changes_file.close()


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument('-s', '--source-dir',
                        required=True,
                        help='source directory')
    
    parser.add_argument('-d', '--dest-dir',
                        required=True,
                        help='destination directory')
    
    parser.add_argument('-l', '--latest',
                        action='store_true',
                        help='source file name')
    
    return parser.parse_args()


def main():
    args = get_args()
    
    if not os.path.isdir(args.dest_dir + '/changes_json'):
        os.mkdir(args.dest_dir + '/changes_json')
    
    files = sorted(os.listdir(args.source_dir + '/details_json'))
    
    if args.latest:
        day2 = files.pop()
        day1 = files.pop()
        compare_days_file(args.source_dir, args.dest_dir, day1, day2)
    else:
        for i in range(1, len(files)):
            compare_days_file(args.source_dir, args.dest_dir, files[i-1], files[i])


if __name__ == '__main__':
    main()
