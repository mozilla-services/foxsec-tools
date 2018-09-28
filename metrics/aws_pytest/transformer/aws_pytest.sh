# Wrapper for running the main aws_pytest transformer

# Install aws_cli
pip3 install awscli --upgrade

# Clone repo
git clone --depth 1 https://$cloudsecBotPat@github.com/mozilla-services/foxsec-results.git
resdir=foxsec-results/aws-pytest

today=`date +%F`

for filename in $resdir/*/*$today.json; do
	acc=$(basename $(dirname $filename))
	aws s3 cp $filename s3://foxsec-metrics/aws_pytest/raw/$acc/
done

# Perform the transformation
mkdir out
./pytest_services_metrics.py -s $resdir -d out -D $today
aws s3 cp out/$today s3://foxsec-metrics/aws_pytest/aws_service_json/
