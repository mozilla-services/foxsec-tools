# Wrapper for running the main github transformer
# executed as:
#  docker pull hub.prod.mozaws.net/mozilla/mozcloudsec-foxsec:latest
#  docker run --rm -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e HEROKU_API_KEY -t hub.prod.mozaws.net/mozilla/mozcloudsec-foxsec bash -xc "git clone --branch '#58_add_heroku' --depth 1 https://github.com/hwine/foxsec-tools.git; cd foxsec-tools/metrics/heroku; transformers/heroku_wrapper.sh"


set -eux
# Install other tools
# Docker preferred method https://devcenter.heroku.com/articles/heroku-cli#other-installation-methods
curl https://cli-assets.heroku.com/install.sh | sh

# Install python tools we need
pip3 install awscli

# get the data
date=$(date --utc --iso)
mkdir upload
member_file_raw=upload/$date-members-raw.json
member_file=upload/$date-members.json

# Get the data
heroku members --team=mozillacorporation --json >$member_file_raw

# Add date to record & reformat for Athena
jq -erc ".[] | . + {\"date\": \"${date}\" }" \
  <$member_file_raw \
  >$member_file

# upload the data
aws s3 cp $member_file_raw s3://foxsec-metrics/heroku/raw/
aws s3 cp $member_file     s3://foxsec-metrics/heroku/members_json/
