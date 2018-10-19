# Wrapper for running the main github transformer

# Install python tools we need
pip3 install --upgrade \
  awscli \
  poetry \

# get the repository we need and set it up
git clone https://github.com/mozilla-services/GitHub-Audit
cd GitHub-Audit
poetry install

# run tests for now
poetry run ./get_branch_protections.py mozilla-frontend-infra

# bail for now
exit 33

### Sync todays files
##today=`date +%F`
##mkdir s3bucket
##mkdir out
##aws s3 cp s3://foxsec-metrics/pyup/raw/$today.pyup_dash.json s3bucket/
##
### Run transformer for today
##python3 transformers/pyup.py -s s3bucket/ -d out/ -D "$today"
## 
### Write todays file to aws
##aws s3 cp out/$today s3://foxsec-metrics/pyup/pyup_json/$today
