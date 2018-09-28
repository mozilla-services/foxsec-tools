# Wrapper for running the observatory collector

# Install aws_cli
pip3 install awscli --upgrade

# Clone repo
git clone https://$cloudsecBotPat@github.com/mozilla-services/foxsec.git

day=`date '+%Y-%M-%d'`

# Generate latest json file
mkdir out
python3 collectors/observatory.py -s foxsec/services/metadata > out/$day 
 
# Write to aws
aws s3 cp out/$day s3://foxsec-metrics/observatory/raw_json/
