#!/usr/bin/env python3

"""
Script to generate checklist files via Athena queries
"""

import argparse
import botocore
import boto3
import json
import os
import os.path
import time
import sys
from datetime import date, timedelta, datetime


# Useful if we know some of the jobs are failing, eg:
#start_day = datetime(2018, 10, 31)
start_day = date.today()


def col_data_to_list(col_data):
	res = []
	for col in col_data:
		res.append(col['VarCharValue'])
	return res


def get_rra_query():
	return ("SELECT 'Risk Management' AS section, 'Must have RRA' AS item, foxsec_metrics.metadata_services.service, " +
		"'' as site, 'global' as environment, CASE WHEN foxsec_metrics.metadata_services.rradate = '' THEN False ELSE True END pass " +
		"FROM foxsec_metrics.metadata_services")


def get_observatory_query():
	return ("SELECT 'Web Applications' AS section, 'A plus on Observatory' AS item, foxsec_metrics.metadata_urls.service, " +
		"foxsec_metrics.observatory.site, foxsec_metrics.metadata_urls.status AS environment, " +
		" CASE WHEN foxsec_metrics.observatory.observatory_score >= 100 THEN True ELSE False END pass " +
		"FROM foxsec_metrics.observatory, foxsec_metrics.metadata_urls " +
		"WHERE foxsec_metrics.observatory.site = foxsec_metrics.metadata_urls.url AND foxsec_metrics.observatory.day = '<<DAY>>' ")


def get_github_query_2fa():
	return ("SELECT 'Development' AS section, 'Enforce 2FA' AS item, a.service, '' as site, 'global' as environment, " +
		"every(b.body.two_factor_requirement_enabled) AS pass " +
		"FROM foxsec_metrics.metadata_repo_parsed AS a, foxsec_metrics.github_object AS b " +
		"JOIN (SELECT max(b2.date) AS MaxDay  FROM foxsec_metrics.github_object as b2) ON b.date = MaxDay " +
		"GROUP BY (service)")


def get_github_query_branch_protection():
	return ("SELECT 'Development' AS section, 'Enforce branch protection' AS item, service, '' as site, 'global' as environment, " +
		"every(protected) AS pass FROM foxsec_metrics.default_branch_protection_status " +
		"JOIN (SELECT max(default_branch_protection_status.date) AS MaxDay " +
		"FROM foxsec_metrics.default_branch_protection_status) md ON default_branch_protection_status.date = MaxDay " +
		"GROUP BY service")


def get_baseline_query(section, item, column):
	return ("SELECT '" + section + "' AS section, '" + item + "' AS item, foxsec_metrics.metadata_urls.service, " +
		"foxsec_metrics.baseline_details.site, foxsec_metrics.metadata_urls.status as environment, " + 
		"CASE WHEN foxsec_metrics.baseline_details.status = 'pass' THEN True ELSE False END pass " +
		"FROM foxsec_metrics.baseline_details, foxsec_metrics.metadata_urls " +
		"WHERE foxsec_metrics.baseline_details.site = foxsec_metrics.metadata_urls.url and " +
		"foxsec_metrics.baseline_details.rule = '" + column + "' and " +
		"foxsec_metrics.baseline_details.day = '<<DAY>>' ")


def run_raw_query(query):
	sys.stderr.write (query + "\n")
	client = boto3.client('athena', region_name='us-east-1')
	clients3 = boto3.client('s3', region_name='us-east-1')
	bucket = 'foxsec-metrics'
	tempdir = 's3://' + bucket + '/temp/'
	response = client.start_query_execution(
		QueryString=query,
		ResultConfiguration={
			'OutputLocation': tempdir,
		})
	
	qeid = response['QueryExecutionId']
	#print('qeid=' + qeid)
	rows_found = 0
	for x in range(0, 10):
		response = client.get_query_execution(QueryExecutionId=qeid)
		#print (response)
		state = response['QueryExecution']['Status']['State']
		#print('State=' + state)
		if state == 'RUNNING':
			time.sleep(2)
		elif state == 'SUCCEEDED':
			response = client.get_query_results(QueryExecutionId=qeid)
			#print (response)
			col_headers = []
			for row in response['ResultSet']['Rows']:
				#print('---')
				#print(row)
				if len(col_headers) == 0:
					col_headers = col_data_to_list(row['Data'])
				else :
					row_json = {}
					col_data = col_data_to_list(row['Data'])
					
					i = 0
					for header in col_headers:
						#print(col['VarCharValue'])
						row_json[header] = col_data[i]
						i+=1
					
					print(json.dumps(row_json))
					rows_found += 1
				
			#print ('Parsed result: ' + response['ResultSet']['Rows'][1]['Data'][0]['VarCharValue'])
			# Delete the files
			clients3.delete_object(Bucket=bucket, Key='temp/' + qeid + '.csv')
			clients3.delete_object(Bucket=bucket, Key='temp/' + qeid + '.csv.metadata')
			break
		else:
			sys.stderr.write ('Failed - see response for details\n')
			sys.stderr.write (str(response))
			sys.stderr.write ('\n')
			break
	return rows_found


def run_day_query(query):
	day = start_day
	for loop in range(0, 6):
		if run_raw_query(query.replace('<<DAY>>', day.strftime("%Y-%m-%d"))) > 0:
			break
		day -= timedelta(1)


def main():
	# Risk Management
	run_raw_query(get_rra_query())
	
	# Infrastructure
	run_day_query(get_baseline_query('Web Applications', 'Set STS', 'rule_10035'))
	
	# Development
	run_raw_query(get_github_query_2fa())
	run_raw_query(get_github_query_branch_protection())
	
	# Web applications
	run_day_query(get_baseline_query('Web Applications', 'CSP present', 'rule_10038'))
	run_day_query(get_baseline_query('Web Applications', 'Content type', 'rule_10019'))
	run_day_query(get_baseline_query('Web Applications', 'Cookies httponly', 'rule_10010'))
	run_day_query(get_baseline_query('Web Applications', 'Cookies secure', 'rule_10011'))
	run_day_query(get_baseline_query('Web Applications', 'No baseline failures', 'status'))
	run_day_query(get_observatory_query())

	# Security features
	run_day_query(get_baseline_query('Security Features', 'Anti CSRF tokens', 'rule_10202'))

	# Common issues
	run_day_query(get_baseline_query('Web Applications', 'Prevent reverse tabnabbing', 'rule_10108'))

if __name__ == '__main__':
	main()
