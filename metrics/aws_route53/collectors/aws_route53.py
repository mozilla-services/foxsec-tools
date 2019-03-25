#!/usr/bin/env python

"""
Script which generates the differences between the dns records downloaded from AWS Route 53

It assumes the relevant files are all under the 's3' directory, eg as a result of:

	aws s3 sync s3://foxsec-metrics/aws_route53/ s3/
		
"""

import glob
import json
import os
import sys

ignore_list = [
    "phx-sync",
    "sync-",
    "scl2-sync",
    "discoslave",
    "app.autopush.autopush-prod-app-",
    "app.pushgo.simplepush-prod",
]


def ignore(url):
    for ig in ignore_list:
        if url.startswith(ig):
            return True
    return False


def read_in_dns_json(file_path):
    with open(file_path) as f:
        dns_json = json.load(f)

    dns_urls = []
    for rr in dns_json:
        name = rr["Name"]
        if not ignore(name):
            dns_urls.append(name[:-1])

    # De-dup and sort
    return sorted(set(dns_urls))


def main():
	
	dir = 's3'
	raw_dir = dir + '/raw'
	generate = []
	
	# Loop through subdirectories
	for d in sorted(glob.glob(raw_dir + "/*/")):
		# Loop through files
		days = []
		acc = d[7:-1]
		print('Account ' + acc)
		# Add to the list of days not yet handled
		for file in sorted(glob.glob(d + "*.json")):
			day = file[-15:-5]
			days.append(day)
			if not os.path.isfile(dir + "/diffs/" + day + ".json"):
				generate.append(day)
				
		# Loop through all of the days for this account generating files for any not yet handled
		for x in range(1, len(days)):
			cur_day = days[x]
			prev_day = days[x-1]
			if cur_day in generate:
				print('Compare ' + prev_day + ' with ' + cur_day)
				# Append in case we ever have multiple accounts
				diffs_file = open(dir + "/diffs/" + cur_day + ".json",'a')
				
				dns_1_urls = read_in_dns_json(raw_dir + "/" + acc + "/" + prev_day + ".json")
				dns_2_urls = read_in_dns_json(raw_dir + "/" + acc + "/" + cur_day + ".json")
			
				for dns_url in dns_2_urls:
					if dns_url not in dns_1_urls:
						data = {}
						data['day'] = cur_day
						data['account'] = acc
						data['action'] = "added"
						data['url'] = dns_url
						diffs_file.write(json.dumps(data) + '\n')
			
				for dns_url in dns_1_urls:
					if dns_url not in dns_2_urls:
						data = {}
						data['day'] = cur_day
						data['account'] = acc
						data['action'] = "removed"
						data['url'] = dns_url
						diffs_file.write(json.dumps(data) + '\n')
				
				diffs_file.close()

if __name__ == "__main__":
    main()
