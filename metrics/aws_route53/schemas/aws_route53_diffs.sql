CREATE EXTERNAL TABLE IF NOT EXISTS aws_route53_diffs (
  `account` STRING,
  `action` STRING,
  `day` STRING,
  `url` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/aws_route53/diffs/';