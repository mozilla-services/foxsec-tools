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
aws s3 cp s3://foxsec-metrics/pyup/raw/$today.pyup_dash.json s3bucket/

# Run transformer for today
python3 transformers/baseline.py -s s3bucket/ -d out/ -D "$today"
 
# Write todays file to aws
aws s3 cp out/$today s3://foxsec-metrics/baseline/baseline_json/$today
