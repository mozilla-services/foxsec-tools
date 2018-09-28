#!/usr/bin/env python3

import argparse
import collections
import datetime
import json
import fnmatch
import os
import re


def handle_day_files(src_dir, dest_dir, day_str):
    for file in sorted(os.listdir(src_dir)):
      if os.path.isdir(src_dir + '/' + file):
        account = file
        print('Got account: ' + account)
        # Loop through json files in dir
        for acc_file in fnmatch.filter(sorted(os.listdir(src_dir + '/' + account)), "*-" + day_str + ".json"):
          output_file = open(dest_dir + '/' + day_str,'a')
          
          # Analyse the files
          with open(src_dir + '/' + account + '/' + acc_file) as f:
            data = json.load(f)
            # Print # results?
            if not "results" in data:
              print("No results in " + src_dir + '/' + account + '/' + acc_file)
              continue
            if len(data["results"]) == 0:
              print("Zero results in " + src_dir + '/' + account + '/' + acc_file)
              continue
            for res in data["results"]:
              resDict = {}
              resDict['day'] = day_str;
              resDict['account'] = account
              resDict['name'] = res['name']
              resDict['test_name'] = res['test_name']
              resDict['status'] = res['status']
              resDict['value'] = res['value']
    
              output_file.write(json.dumps(resDict) + '\n')
        
          output_file.close()

    
    # todo regex match
    file_name = src_dir + day_str + '.pyup_dash.json'
    if not os.path.isfile(file_name):
        return

    with open(file_name, 'r') as f:
        data = json.load(f)

    json_file = open(dest_dir + '/' + day_str,'w')

    for res in data['results']:
        res['day'] = day_str
        json_file.write(json.dumps(res) + '\n')

    json_file.close()


def handle_all_files(src_dir, dest_dir):
    # the earliest date
    date = datetime.datetime(2018,2,5)
    today = datetime.datetime.now().strftime("%Y-%m-%d")
    while True: 
        day_str = date.strftime("%Y-%m-%d")
        handle_day_files(src_dir, dest_dir, day_str)
        if day_str == today:
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
    
    parser.add_argument('-D', '--day',
                        help='date, as YYYY-MM-dd')
    
    return parser.parse_args()


def main():
    args = get_args()
    if args.day:
        handle_day_files(args.source_dir, args.dest_dir, args.day)
    else:
        handle_all_files(args.source_dir, args.dest_dir)


if __name__ == '__main__':
    main()
