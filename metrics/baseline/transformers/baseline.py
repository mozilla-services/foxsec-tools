#!/usr/bin/env python3

import argparse
import collections
import datetime
import json
import os
import re

ruleDict = {}


def handle_site(file, site, date, sites_file, details_file):
    siteDict = {}
    siteDict["site"] = site
    siteDict["day"] = date
    rule2res = {}
    rule2res2 = {}
    lastRule = None
    with open(file, "r") as f:
        for line in f:
            if line.startswith("Total of"):
                countStr = line[9:-6]
                siteDict["urlCount"] = int(countStr)
            # Extract rule id
            m = re.search("\[(.+?)\]", line)
            if m and ":" in line:
                rule = "rule_" + m.group(1)
                lastRule = rule
                rule2res[rule] = line[0 : line.index(":")].replace("-", "_").lower()
                # Extract the desc
                d = re.search(": (.+?) \[", line)
                ruleDict[rule] = d.group(1)
                # Save the per rule details
                res2 = {}
                res2["site"] = site
                res2["day"] = date
                res2["rule"] = rule
                res2["status"] = rule2res[rule]
                res2["description"] = ruleDict[rule]
                rule2res2[rule] = res2
            elif line.startswith("\tProgress"):
                # This applies to the last rule
                rule2res2[lastRule]["progressLink"] = line[line.index("http") : -1]
            elif line.startswith("\t"):
                # These apply to the last rule
                if "failingUrls" in rule2res2[lastRule]:
                    rule2res2[lastRule]["failingUrls"] += " " + line[1:-1]
                else:
                    rule2res2[lastRule]["failingUrls"] = line[1:-1]
            elif line.startswith("GROUP: "):
                siteDict["service"] = line[7:-1]
    siteDict.update(collections.Counter(rule2res.values()))
    if "fail" in siteDict or "fail_new" in siteDict or "fail_in_progress" in siteDict:
        siteDict["status"] = "fail"
    else:
        siteDict["status"] = "pass"
    # siteDict.update(rule2res)
    sites_file.write(json.dumps(siteDict) + "\n")

    for rule in rule2res2:
        details_file.write(json.dumps(rule2res2[rule]) + "\n")


def handle_day_files(src_dir, dest_dir, day_str):
    sites_file = open(dest_dir + "/sites_json/" + day_str, "w")
    details_file = open(dest_dir + "/details_json/" + day_str, "w")

    sites = 0
    for file in sorted(os.listdir(src_dir)):
        if os.path.isdir(src_dir + file):
            if os.path.isfile(src_dir + file + "/" + day_str):
                sites += 1
                handle_site(
                    src_dir + file + "/" + day_str,
                    file,
                    day_str,
                    sites_file,
                    details_file,
                )

    details_file.close()
    sites_file.close()
    if sites == 0:
        print("Day : " + day_str + " Sites : " + str(sites) + " (deleting)")
        os.unlink(dest_dir + "/sites_json/" + day_str)
        os.unlink(dest_dir + "/details_json/" + day_str)
    else:
        print("Day : " + day_str + " Sites : " + str(sites))


def handle_all_files(src_dir, dest_dir):
    # the earliest date
    date = datetime.datetime(2016, 6, 29)
    today = datetime.datetime.now().strftime("%Y-%m-%d")
    while True:
        day_str = date.strftime("%Y-%m-%d")
        handle_day_files(src_dir, dest_dir, day_str)
        if day_str == today:
            break
        date += datetime.timedelta(days=1)


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument("-s", "--source-dir", required=True, help="source directory")

    parser.add_argument("-d", "--dest-dir", required=True, help="destination directory")

    parser.add_argument("-f", "--file", help="source file name")

    return parser.parse_args()


def main():
    args = get_args()

    if not os.path.isdir(args.dest_dir + "/details_json"):
        os.mkdir(args.dest_dir + "/details_json")
    if not os.path.isdir(args.dest_dir + "/sites_json"):
        os.mkdir(args.dest_dir + "/sites_json")
    if not os.path.isdir(args.dest_dir + "/rules_json"):
        os.mkdir(args.dest_dir + "/rules_json")

    if args.file:
        handle_day_files(args.source_dir, args.dest_dir, args.file)
    else:
        handle_all_files(args.source_dir, args.dest_dir)

    # Special case - this gives too much specific detail and so isnt useful here
    ruleDict["rule_322420463"] = "A vulnerable library has been detected"
    rules_file = open(args.dest_dir + "/rules_json/rules.json", "w")
    for rule in sorted(ruleDict):
        r = {}
        r["rule"] = rule
        r["description"] = ruleDict[rule]
        rules_file.write(json.dumps(r) + "\n")
    rules_file.close()


if __name__ == "__main__":
    main()
