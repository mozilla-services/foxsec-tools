CREATE EXTERNAL TABLE IF NOT EXISTS baseline_all_changes (
  `day` STRING,
  `prev` STRING,
  `site` STRING,
  `old_status` STRING,
  `new_status` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/baseline/changes_json/';
