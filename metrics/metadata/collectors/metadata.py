#!/usr/bin/env python3

"""
Script to generate json files from the service metadata
"""

import argparse
import json
import os
import os.path


def optional (obj, key):
	if key in obj:
		return obj[key]
	return ''


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument('-s', '--source-dir',
			default='.',
			help='source directory')
    
    parser.add_argument('-d', '--dest-dir',
						default='.',
			help='destination directory')
    
    return parser.parse_args()


def main():
	args = get_args()

	services_file = open(args.dest_dir + '/metadata_services.json','w')
	urls_file = open(args.dest_dir + '/metadata_urls.json','w')
	repos_file = open(args.dest_dir + '/metadata_repos.json','w')
	raw_file = open(args.dest_dir + '/metadata.json','w')
	
	for filename in os.listdir(args.source_dir):
		if filename.endswith(".json"): 
			with open(os.path.join(args.source_dir, filename)) as f:
				service_json = json.load(f)

			# Top level metadata
			meta_data = {}
			meta_data['service'] = service_json['service']
			meta_data['serviceKey'] = optional(service_json, 'serviceKey')
			meta_data['rra'] = service_json['rra']
			meta_data['risk'] = service_json['risk']
			meta_data['riskSummary'] = optional(service_json, 'riskSummary')
			meta_data['rraDate'] = optional(service_json, 'rraDate')
			meta_data['rraData'] = optional(service_json, 'rraData')
			meta_data['rraImpact'] = optional(service_json, 'rraImpact')
			meta_data['awsAppTags'] = optional(service_json, 'awsAppTags')

			services_file.write(json.dumps(meta_data) + '\n')

			# URLs
			for site in service_json['sites']:
				for url in site['urls']:
					data = {}
					data['service'] = service_json['service']
					data['serviceKey'] = optional(service_json, 'serviceKey')
					data['category'] = optional(site, 'category')
					data['url'] = url['url']
					data['path'] = url['path']
					data['status'] = url['status']
					data['qualifier'] = optional(url, 'qualifier')
					
					urls_file.write(json.dumps(data) + '\n')

			# Repos
			for repo in service_json['sourceControl']:
					data = {}
					data['service'] = service_json['service']
					data['serviceKey'] = optional(service_json, 'serviceKey')
					data['repo'] = repo
					
					repos_file.write(json.dumps(data) + '\n')

			# Raw
			raw_file.write(json.dumps(service_json) + '\n')

	services_file.close()
	urls_file.close()
	repos_file.close()
	raw_file.close()


if __name__ == '__main__':
	main()
