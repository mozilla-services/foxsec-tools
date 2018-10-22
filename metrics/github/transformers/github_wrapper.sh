# Wrapper for running the main github transformer

set -eux
# Install other tools
apt update && apt install -y jq

# Install python tools we need
pip3 install --upgrade \
  awscli \
  poetry \

# get the repository we need and set it up
git clone --depth 1 https://github.com/mozilla-services/GitHub-Audit
cd GitHub-Audit
poetry install

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
