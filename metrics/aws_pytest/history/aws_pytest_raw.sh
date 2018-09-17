# One off script for copying aws_pytest data from foxsec_results to S3

# Install aws_cli
pip3 install awscli --upgrade

# Set up the aws credentials
mkdir ~/.aws
cat > ~/.aws/credentials <<DELIM
[default]
aws_access_key_id = $AWS_ACCESS_KEY
aws_secret_access_key = $AWS_SECRET_KEY
DELIM

# Clone repo
git clone https://$cloudsecBotPat@github.com/mozilla-services/foxsec-results.git
cd foxsec-results/aws-pytest

# Remove the things we dont want
rm placeholder */placeholder */one-offs
rm */*.csv */*.md

# Sync to aws
aws s3 sync . s3://foxsec-metrics/aws_pytest/raw
