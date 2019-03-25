# Wrapper for running the aws_router53 collector

# Install aws_cli
pip3 install awscli --upgrade

# Copy files from aws
aws s3 sync s3://foxsec-metrics/aws_route53/ s3/

# Generate latest json files
python3 collectors/aws_route53.py 
 
# Write diffs to aws
aws s3 sync s3/diffs/ s3://foxsec-metrics/aws_route53/diffs/