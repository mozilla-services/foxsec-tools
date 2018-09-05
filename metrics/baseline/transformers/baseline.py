#!/usr/bin/env python3

import argparse
import collections
import datetime
import json
import os
import re


def handle_site (file, site, date, json_file):
    siteDict = {}
    siteDict['site'] = site
    siteDict['day'] = date
    rule2res = {}
    with open(file, 'r') as f:
      for line in f:
        # Extract rule id
        m = re.search('\[(.+?)\]', line)
        if m and ':' in line:
          rule2res['rule_' + m.group(1)] = line[0:line.index(':')].replace('-', '_').lower()
    siteDict.update(collections.Counter(rule2res.values()))
    if 'FAIL' in siteDict or 'FAIL_NEW' in siteDict:
        siteDict['status'] = 'fail'
    else:
        siteDict['status'] = 'pass'
    siteDict.update(rule2res)
    json_file.write(json.dumps(siteDict) + '\n')

  
def handle_day_files(src_dir, dest_dir, day_str):
    json_file = open(dest_dir + '/' + day_str,'w')
    
    sites = 0
    for file in sorted(os.listdir(src_dir)):
      if os.path.isdir(src_dir + file):
        if os.path.isfile(src_dir + file + '/' + day_str):
          sites += 1
          handle_site(src_dir + file + '/' + day_str, file, day_str, json_file)
    
    json_file.close()
    if sites == 0:
      print("Day : " + day_str + " Sites : " + str(sites) + ' (deleting)')
      os.unlink(dest_dir + '/' + day_str)
    else:
      print("Day : " + day_str + " Sites : " + str(sites))


def handle_all_files(src_dir, dest_dir):
    # the earliest date
    date = datetime.datetime(2016,6,29)
    today = datetime.datetime.now().strftime("%Y-%m-%d")
    while True: 
        day_str = date.strftime("%Y-%m-%d")
        handle_day_files(src_dir, dest_dir, day_str)
        if date == today:
            break;  
        date += datetime.timedelta(days=1)


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument('-s', '--source-dir',
                        required=True,
                        help='source directory')
    
    parser.add_argument('-d', '--dest-dir',
                        required=True,
                        help='destination directory')
    
    parser.add_argument('-f', '--file',
                        help='source file name')
    
    return parser.parse_args()


def main():
    args = get_args()
    if args.file:
        handle_day_files(args.source_dir, args.dest_dir, args.file)
    else:
        handle_all_files(args.source_dir, args.dest_dir)


if __name__ == '__main__':
    main()
