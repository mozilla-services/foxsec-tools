CREATE EXTERNAL TABLE IF NOT EXISTS aws_outdated_amis (
  `account` STRING,
  `ami_name` STRING,
  `instance_app` STRING,
  `day` STRING,
  `instance_name` STRING,
  `instance_owner` STRING,
  `instance_stack` STRING,
  `status` STRING,
  `test_name` STRING,
  `instance_type` STRING,
  `value` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/aws_outdated_amis/aws_outdated_amis_json/';
