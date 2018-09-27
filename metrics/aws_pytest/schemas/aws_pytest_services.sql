CREATE EXTERNAL TABLE IF NOT EXISTS aws_pytest_services (
  `account` STRING,
  `day` STRING,
  `name` STRING,
  `status` STRING,
  `test_name` STRING,
  `value` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/aws_pytest/aws_service_json/';
