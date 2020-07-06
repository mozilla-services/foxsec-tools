#!/usr/bin/env python

import argparse
import datetime
import json
import os
import os.path
import requests
import sys
from time import sleep

today = datetime.datetime.today().strftime("%Y-%m-%d")


def observatory_score(url):
    req = requests.get(
        "https://http-observatory.security.mozilla.org/api/v1/analyze?host=" + url
    )
    res = json.loads(req.content.decode("utf-8"))
    if "score" in res and res["score"]:
        return res["score"]
    # Try again - looks like we often get failures :/
    sleep(5)
    req = requests.get(
        "https://http-observatory.security.mozilla.org/api/v1/analyze?host=" + url
    )
    res = json.loads(req.content.decode("utf-8"))
    if "score" in res and res["score"]:
        return res["score"]

    # Request an assessment, for next time
    requests.post(
        "https://http-observatory.security.mozilla.org/api/v1/analyze?host=" + url
    )

    return -1


def observatory_scores(src_dir):
    for filename in sorted(os.listdir(src_dir)):
        if filename.endswith(".json"):
            with open(os.path.join(src_dir, filename)) as f:
                service = filename[:-5]
                jsn = json.load(f)
                for site in jsn["sites"]:
                    for urlinfo in site["urls"]:
                        url = urlinfo["url"]
                        data = {}
                        data["service"] = service
                        data["day"] = today
                        data["site"] = url
                        data["observatory_score"] = observatory_score(urlinfo["url"])
                        print(json.dumps(data))


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument(
        "-m", "--metadata-dir", required=True, help="metadata directory"
    )
    return parser.parse_args()


def main():
    args = get_args()
    observatory_scores(args.metadata_dir)


if __name__ == "__main__":
    main()
