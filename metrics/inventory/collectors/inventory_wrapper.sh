# Wrapper for running the inventory collector

# Install aws_cli
pip3 install awscli --upgrade

# Clone inventory repo
git clone https://$cloudsecBotPat@github.com/mozilla-services/inventory.git

# remove the first line containing the column headers
mkdir out
tail -n+2 inventory/application_registry.csv > out/application_registry.csv
tail -n+2 inventory/application_component_registry.csv > out/application_component_registry.csv

# Write to aws
aws s3 cp out/application_registry.csv s3://foxsec-metrics/inventory/inventory_appplication_csv/application_registry.csv
aws s3 cp out/application_component_registry.csv s3://foxsec-metrics/inventory/inventory_appplication_component_csv/application_component_registry.csv
