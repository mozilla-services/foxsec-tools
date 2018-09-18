CREATE EXTERNAL TABLE IF NOT EXISTS pyup (
  `badge_status` STRING,
  `badge_url` STRING,
  `day` STRING,
  `link` STRING,
  `repo_url` STRING,
  `status` STRING,
  `value` INT
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/pyup/pyup_json/';
