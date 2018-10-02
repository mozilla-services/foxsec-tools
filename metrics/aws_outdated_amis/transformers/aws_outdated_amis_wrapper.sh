# Wrapper for running the main aws_outdated_amis transformer

# Install aws_cli
pip3 install awscli --upgrade

# Clone repo
git clone --depth 1 https://$cloudsecBotPat@github.com/mozilla-services/foxsec-results.git
resdir=foxsec-results/aws-outdated-amis

today=`date +%F`

for filename in $resdir/*/*$today.json; do
	acc=$(basename $(dirname $filename))
	aws s3 cp $filename s3://foxsec-metrics/aws_pytest/raw/$acc/
done

# Perform the transformation
mkdir out
./aws_outdated_amis.py -s $resdir -d out -D $today
aws s3 cp out/$today s3://foxsec-metrics/aws_outdated_amis/aws_outdated_amis_json/
