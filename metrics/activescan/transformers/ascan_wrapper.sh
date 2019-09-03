# Wrapper for running the main active scan transformer

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
aws s3 sync s3://foxsec-metrics/ascan/raw/ s3bucket --exclude "*" --include "*/$today"

# Run transformers for today
python3 transformers/ascan.py -s s3bucket/ -d out/ -f "$today"

# Also need at least one previous result
aws s3 sync s3://foxsec-metrics/ascan/details_json/ out/details_json/ --exclude "*" --include "`date --date="1 day ago" +%F`"
aws s3 sync s3://foxsec-metrics/ascan/details_json/ out/details_json/ --exclude "*" --include "`date --date="2 day ago" +%F`"
aws s3 sync s3://foxsec-metrics/ascan/details_json/ out/details_json/ --exclude "*" --include "`date --date="3 day ago" +%F`"

python3 transformers/ascan_changes.py -s out/ -d out/ -l

 
# Write todays files to aws
aws s3 cp out/details_json/$today s3://foxsec-metrics/ascan/details_json/$today
aws s3 cp out/sites_json/$today s3://foxsec-metrics/ascan/sites_json/$today
aws s3 cp out/changes_json/$today s3://foxsec-metrics/ascan/changes_json/$today
aws s3 cp out/sites_json/$today s3://foxsec-metrics/ascan/sites_latest_json/sites.json
aws s3 cp out/rules_json/rules.json s3://foxsec-metrics/ascan/rules_json/rules.json
