#!/bin/bash

set -e

# Wrapper for running the main aws_pytest transformer

# Install aws_cli
pip3 install awscli --upgrade

today=$(date +%F)
tdir=$(mktemp -d)

aws s3 sync s3://foxsec-metrics/aws_pytest/raw/ $tdir --exclude "*" --include "*${today}.json"

# Perform the transformation
mkdir out
./pytest_services_metrics.py -s $tdir -d out -D $today
aws s3 cp out/$today s3://foxsec-metrics/aws_pytest/aws_service_json/
