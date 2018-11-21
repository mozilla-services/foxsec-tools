# Wrapper for running the checklist collector

# Install aws_cli and boto3
pip3 install awscli boto3 --upgrade

# Clone repo
git clone https://$cloudsecBotPat@github.com/mozilla-services/foxsec.git

day=`date '+%Y-%m-%d'`

# Generate latest json file
mkdir out
python3 collectors/checklist.py > out/checklist.json 
 
# Write to aws
aws s3 cp out/checklist.json s3://foxsec-metrics/checklist/raw_json/checklist.json
