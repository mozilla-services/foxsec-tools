#!/usr/bin/env python
'''
Request a new scan of all URLs in the metadata
'''

import argparse
import datetime
import json
import os
import os.path
import requests
import sys


def observatory_scan(src_dir):
    for filename in sorted(os.listdir(src_dir)):
        if filename.endswith(".json"):
            with open(os.path.join(src_dir, filename)) as f:
                service = filename[:-5]
                jsn = json.load(f)
                for site in jsn['sites']:
                    for urlinfo in site['urls']:
                        url = urlinfo['url']
                        r = requests.post(
                            'https://http-observatory.security.mozilla.org/api/v1/analyze?host=' + url)
                        print(url + ' ' + str(r.status_code))


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument('-m', '--metadata-dir',
                        required=True,
                        help='metadata directory')
    return parser.parse_args()


def main():
    args = get_args()
    observatory_scan(args.metadata_dir)


if __name__ == '__main__':
    main()
