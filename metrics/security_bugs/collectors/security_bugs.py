#!/usr/bin/env python3

"""
Script to generate json files from the bugzilla security bugs
"""

import argparse
import json
import os
import os.path
import requests

BIGZILLA_BASE_URL = "https://bugzilla.mozilla.org/rest/"
BUGZILLA_API_KEY = os.environ["BUGZILLA_API_KEY"]


def get_bug(bugid):
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "X-BUGZILLA-API-KEY": BUGZILLA_API_KEY,
    }
    return requests.get(BIGZILLA_BASE_URL + "bug/" + str(bugid), headers=headers)


def get_bugs(bugids):
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "X-BUGZILLA-API-KEY": BUGZILLA_API_KEY,
    }
    return requests.get(
        BIGZILLA_BASE_URL + "bug?id=" + ",".join(map(str, bugids)), headers=headers
    )


def get_bugs_for_component(product, component, retrys):
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "X-BUGZILLA-API-KEY": BUGZILLA_API_KEY,
    }

    for i in range(1, retrys):
        resp = requests.get(
            BIGZILLA_BASE_URL + "bug?product=" + product + "&component=" + component,
            headers=headers,
        )
        if resp.status_code == 200:
            return resp
        else:
            print("Retry " + str(i) + " " + product + " : " + component)

    return resp


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument("-s", "--source-dir", default=".", help="source directory")

    parser.add_argument("-d", "--dest-dir", default=".", help="destination directory")

    parser.add_argument("-f", "--service_file", help="optional service file")

    return parser.parse_args()


def is_sec_bug(bug):
    for keyword in bug["keywords"]:
        if keyword.startswith("sec-") or keyword.startswith("wsec-"):
            return True
    if len(get_flag(bug, "sec-bounty")) > 0:
        return True
    if len(get_first_group_containing(bug, "security")) > 0:
        return True


def get_first_keyword_starting_with(bug, keyword):
    for kw in bug["keywords"]:
        if kw.startswith(keyword):
            return kw
    return ""


def get_first_group_containing(bug, group):
    for gr in bug["groups"]:
        if group in gr:
            return gr
    return ""


def get_flag(bug, flag):
    for fl in bug["flags"]:
        if fl["name"] == flag:
            return fl["status"]
    return ""


def get_sec_bug_data(bug):
    bug_data = {}
    bug_data["bugid"] = bug["id"]
    bug_data["creation_day"] = bug["creation_time"][0:10]
    bug_data["last_change_day"] = bug["last_change_time"][0:10]
    bug_data["status"] = bug["status"]
    bug_data["resolution"] = bug["resolution"]
    bug_data["sec"] = get_first_keyword_starting_with(bug, "sec-")
    bug_data["wsec"] = get_first_keyword_starting_with(bug, "wsec-")
    bug_data["bug_bounty"] = get_flag(bug, "sec-bounty")
    bug_data["sec_group"] = get_first_group_containing(bug, "security")
    return bug_data


def handle_service(service_json, dest_file):
    service = service_json["service"]
    secbugs_file = open(dest_file, "w")
    for comp in service_json["bugzilla"]:
        # print(service + "\t" + comp['product'] + " : " + comp['component'])
        if len(comp["product"]) == 0:
            print(service + ":\tNo product/component")
            continue
        bugs_resp = get_bugs_for_component(comp["product"], comp["component"], 5)

        if bugs_resp.status_code == 200:
            bugs_json = json.loads(bugs_resp.text)
            # print('\tBug count: ' + str(len(bugs_json['bugs'])))
            if len(bugs_json["bugs"]) == 0:
                print(
                    service
                    + ":\tNo bugs found in "
                    + comp["product"]
                    + "/"
                    + comp["component"]
                )
            else:

                for bug in bugs_json["bugs"]:
                    if is_sec_bug(bug):
                        bug_json = get_sec_bug_data(bug)
                        bug_json["service"] = service
                        secbugs_file.write(json.dumps(bug_json) + "\n")

        else:
            print(
                service
                + "\tFailed: "
                + str(bugs_resp.status_code)
                + " for "
                + comp["product"]
                + "/"
                + comp["component"]
            )
    secbugs_file.close()


def main():
    args = get_args()

    if args.service_file:
        with open(os.path.join(args.source_dir, args.service_file)) as f:
            service_json = json.load(f)

        handle_service(service_json, args.dest_dir + "/" + args.service_file)

    else:
        for filename in os.listdir(args.source_dir):
            if filename.endswith(".json"):
                with open(os.path.join(args.source_dir, filename)) as f:
                    service_json = json.load(f)

                handle_service(service_json, args.dest_dir + "/" + filename)


if __name__ == "__main__":
    main()
