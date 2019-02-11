#!/usr/bin/env python3

import argparse
import collections
import datetime
import json
import fnmatch
import os
import re


def optional(obj, key):
    if key in obj:
        return obj[key]
    return ''


def handle_day_files(src_dir, dest_dir, day_str):
    for file in sorted(os.listdir(src_dir)):
      if os.path.isdir(src_dir + '/' + file):
        account = file
        #print('Got account: ' + account)
        # Loop through json files in dir
        for acc_file in fnmatch.filter(sorted(os.listdir(src_dir + '/' + account)), "*-" + day_str + ".json"):
          output_file = open(dest_dir + '/' + day_str, 'a')

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
              if res["test_name"] == "test_ec2_instance_running_required_amis":
                resDict = {}
                resDict['day'] = day_str;
                resDict['account'] = account
                resDict['ami_name'] = optional(res['metadata'], 'ImageId')
                resDict['test_name'] = res['test_name']
                resDict['status'] = res['status']
                resDict['value'] = res['value']

                # Extract all of the metadata tags
                tags = {}
                if res['metadata'].get('Tags') is not None:
                  for tagpair in res['metadata']['Tags']:
                    tags[tagpair['Key']] = tagpair['Value']

                resDict['instance_name'] = optional(tags, 'Name')
                resDict['instance_owner'] = optional(tags, 'Owner')
                resDict['instance_stack'] = optional(tags, 'Stack')
                resDict['instance_type'] = optional(tags, 'Type')
                resDict['instance_app'] = optional(tags, 'App')

                output_file.write(json.dumps(resDict) + '\n')

          output_file.close()


def handle_all_files(src_dir, dest_dir):
    # the earliest date
    date = datetime.datetime(2018, 9, 14)
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
