# Wrapper for running the main baseline transformer

# Install aws_cli
pip3 install awscli --upgrade

# Set up the aws credentials
mkdir ~/.aws
cat > ~/.aws/credentials <<DELIM
[default]
aws_access_key_id = $AWS_ACCESS_KEY
aws_secret_access_key = $AWS_SECRET_KEY
DELIM

# Sync todays files
today=`date +%F`
mkdir s3bucket
mkdir out
aws s3 sync s3://foxsec-metrics/baseline/raw/ s3bucket --exclude "*" --include "*/$today"

# Run transformers for today
python3 transformers/baseline.py -s s3bucket/ -d out/ -f "$today"
python3 transformers/baseline_changes.py -s s3bucket/ -d out/ -l

 
# Write todays files to aws
aws s3 cp out/details_json/$today s3://foxsec-metrics/baseline/details_json/$today
aws s3 cp out/sites_json/$today s3://foxsec-metrics/baseline/sites_json/$today
aws s3 cp out/changes_json/$today s3://foxsec-metrics/baseline/changes_json/$today
aws s3 cp out/sites_json/$today s3://foxsec-metrics/baseline/sites_latest_json/sites.json
aws s3 cp out/rules_json/rules.json s3://foxsec-metrics/baseline/rules_json/rules.json
