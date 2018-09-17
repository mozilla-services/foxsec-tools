#!/usr/bin/env python3

import argparse
import collections
import datetime
import json
import os
import re


def handle_day_file(src_dir, dest_dir, day_str):
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
    date = datetime.datetime(2017,9,25)
    today = datetime.datetime.now().strftime("%Y-%m-%d")
    while True: 
        day_str = date.strftime("%Y-%m-%d")
        handle_day_file(src_dir, dest_dir, day_str)
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
        handle_day_file(args.source_dir, args.dest_dir, args.day)
    else:
        handle_all_files(args.source_dir, args.dest_dir)


if __name__ == '__main__':
    main()
