# Wrapper for running the main aws_pytest transformer against all of the raw data

# Install aws_cli
pip3 install awscli --upgrade

# Clone repo
git clone --depth 1 https://$cloudsecBotPat@github.com/mozilla-services/foxsec-results.git
resdir=foxsec-results/aws-pytest

# Perform the transformation
mkdir out
./pytest_services_metrics.py -s $resdir -d out
aws s3 sync out/ s3://foxsec-metrics/aws_pytest/aws_service_json/
