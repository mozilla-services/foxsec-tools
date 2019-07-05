# Wrapper for running the metadata collector

# Install aws_cli
pip3 install awscli --upgrade

# Clone repo
git clone https://$cloudsecBotPat@github.com/mozilla-services/foxsec.git

# Generate latest json files
mkdir out
python3 collectors/metadata.py -s foxsec/services/metadata -d out/ 
 
# Write to aws
aws s3 cp out/metadata_services.json s3://foxsec-metrics/metadata/metadata_services_json/metadata_services.json
aws s3 cp out/metadata_urls.json s3://foxsec-metrics/metadata/metadata_urls_json/metadata_urls.json
aws s3 cp out/metadata_repos.json s3://foxsec-metrics/metadata/metadata_repos_json/metadata_repos.json
aws s3 cp out/metadata.json s3://foxsec-metrics/metadata/raw/metadata.json
