CREATE EXTERNAL TABLE IF NOT EXISTS baseline_rules (
  `description` STRING,
  `rule` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/baseline/rules_json/';
