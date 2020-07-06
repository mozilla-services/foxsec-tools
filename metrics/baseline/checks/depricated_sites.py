#!/usr/bin/env python3
"""
Reports if any:
    'deprecated' sites are no longer accessible
    'terminated' sites are no available
"""

import argparse
import datetime
import json
import os
import os.path
import requests
import sys
from time import sleep

today = datetime.datetime.today().strftime("%Y-%m-%d")


def test_deprecated_url(url):
    try:
        req = requests.get("https://" + url, timeout=20)
        return ""
    except requests.exceptions.ConnectionError:
        return "Deprecated url https://" + url + " no longer accessible\n"


def test_terminated_url(url):
    try:
        req = requests.get("https://" + url, timeout=20)
        return "Terminated url https://" + url + " is still accessible\n"
    except requests.exceptions.ConnectionError:
        return ""


def test_depricated_sites(src_dir):
    result = ""
    for filename in sorted(os.listdir(src_dir)):
        if filename.endswith(".json"):
            with open(os.path.join(src_dir, filename)) as f:
                service = filename[:-5]
                jsn = json.load(f)
                for site in jsn["sites"]:
                    for urlinfo in site["urls"]:
                        if urlinfo["status"] == "deprecated":
                            result += test_deprecated_url(urlinfo["url"])
                        elif urlinfo["status"] == "terminated":
                            result += test_terminated_url(urlinfo["url"])
    if len(result) > 0:
        print(result)


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument(
        "-m", "--metadata-dir", required=True, help="metadata directory"
    )
    return parser.parse_args()


def main():
    args = get_args()
    test_depricated_sites(args.metadata_dir)


if __name__ == "__main__":
    main()
