# Wrapper for running the main github transformer

set -eux
# Install other tools
apt-get --quiet update && apt-get --quiet install -y jq

# Install python tools we need
pip3 install --quiet --upgrade \
  awscli \
  poetry \

# get the repository we need and set it up
git clone --quiet --depth 1 --branch GH-54-fetch-failures https://github.com/mozilla-services/GitHub-Audit
cd GitHub-Audit
poetry install --quiet

# create credential files
echo -e "\n$githubAPItoken" >./.credentials
mkdir -p ~/.aws
cat >~/.aws/credentials <<EOF
[cloudservices-aws-stage]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
EOF

# Run the job
poetry run make -f moz_scripts/Makefile full
