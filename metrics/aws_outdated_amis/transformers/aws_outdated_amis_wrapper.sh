#!/bin/bash

set -e

# Wrapper for running the main aws_outdated_amis transformer

# Install aws_cli
pip3 install awscli --upgrade

today=$(date +%F)
tdir=$(mktemp -d)

aws s3 sync s3://foxsec-metrics/aws_pytest/raw/ $tdir --exclude "*" --include "*${today}.json"

# Perform the transformation
mkdir out
./aws_outdated_amis.py -s $tdir -d out -D $today
aws s3 cp out/$today s3://foxsec-metrics/aws_outdated_amis/aws_outdated_amis_json/
