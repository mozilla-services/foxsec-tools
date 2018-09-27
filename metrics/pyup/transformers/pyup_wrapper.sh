# Wrapper for running the main pyup transformer

# Install aws_cli
pip3 install awscli --upgrade

# Sync todays files
today=`date +%F`
mkdir s3bucket
mkdir out
aws s3 cp s3://foxsec-metrics/pyup/raw/$today.pyup_dash.json s3bucket/

# Run transformer for today
python3 transformers/pyup.py -s s3bucket/ -d out/ -D "$today"
 
# Write todays file to aws
aws s3 cp out/$today s3://foxsec-metrics/pyup/pyup_json/$today
