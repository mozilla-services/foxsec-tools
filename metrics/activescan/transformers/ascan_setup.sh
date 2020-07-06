# Wrapper for running the main ascan transformer against ALL of the existing ascan files

# Install aws_cli
pip3 install awscli --upgrade

mkdir s3bucket
aws s3 sync s3://foxsec-metrics/ascan/ s3bucket/

# Run transformer for all days
python3 transformers/ascan.py -s s3bucket/raw/ -d s3bucket/

# Write all files to aws
aws s3 sync s3bucket/ s3://foxsec-metrics/ascan/
