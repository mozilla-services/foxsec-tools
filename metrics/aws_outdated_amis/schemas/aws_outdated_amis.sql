CREATE EXTERNAL TABLE IF NOT EXISTS aws_outdated_amis (
  `account` STRING,
  `aminame` STRING,
  `app` STRING,
  `day` STRING,
  `name` STRING,
  `owner` STRING,
  `stack` STRING,
  `status` STRING,
  `test_name` STRING,
  `type` STRING,
  `value` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/aws_outdated_amis/aws_outdated_amis_json/';
