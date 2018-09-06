# Wrapper for running the metadata collector

# Install aws_cli
pip3 install awscli --upgrade

# Clone repo
git clone https://$cloudsecBotPat@github.com/mozilla-services/foxsec.git

# Set up the aws credentials
mkdir ~/.aws
cat > ~/.aws/credentials <<DELIM
[default]
aws_access_key_id = $AWS_ACCESS_KEY
aws_secret_access_key = $AWS_SECRET_KEY
DELIM

# Generate latest json files
mkdir out
python3 collectors/metadata.py -s foxsec/services/metadata -d out/ 
 
# Write to aws
aws s3 cp out/metadata_services.json s3://foxsec-metrics/metadata/metadata_services_json/metadata_services.json
aws s3 cp out/metadata_urls.json s3://foxsec-metrics/metadata/metadata_urls_json/metadata_urls.json
aws s3 cp out/metadata_repos.json s3://foxsec-metrics/metadata/metadata_repos_json/metadata_repos.json
