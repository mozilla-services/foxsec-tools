# Wrapper for running the main baseline transformer

# Install aws_cli, the uninstall is needed otherwise it doesnt work
pip uninstall awscli -y
pip3 install awscli --upgrade --user

# Set up the aws credentials
mkdir ~/.aws
cat > ~/.aws/credentials <<DELIM
[default]
aws_access_key_id = $AWS_ACCESS_KEY
aws_secret_access_key = $AWS_SECRET_KEY
DELIM

# Pull repo
git clone https://github.com/mozilla-services/foxsec-tools.git
cd foxsec-tools/metrics/baseline

# Sync todays files
today=`date +%F`
mkdir s3bucket
mkdir out
aws s3 sync s3://foxsec-metrics/baseline/raw s3bucket --exclude "*" --include "*/$today"

# Run transformer for today
python3 transformers/baseline.py -s s3bucket/ -d out/ -f "$today"
 
# Write todays file to aws
aws s3 cp out/$today s3://foxsec-metrics/baseline/baseline_json/$today
