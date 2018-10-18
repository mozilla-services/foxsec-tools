# Wrapper for running the metadata collector

# Install aws_cli
pip3 install awscli --upgrade

# Clone repo
git clone https://$cloudsecBotPat@github.com/mozilla-services/foxsec.git

# Generate latest json files
mkdir out
python3 collectors/security_bugs.py -s foxsec/services/metadata -d out/ 
 
# Write to aws
aws s3 sync out/ s3://foxsec-metrics/security_bugs/raw_json/
