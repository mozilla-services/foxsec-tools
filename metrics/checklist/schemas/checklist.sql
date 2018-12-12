CREATE EXTERNAL TABLE IF NOT EXISTS checklist (
  `environment` STRING,
  `item` STRING,
  `link` STRING,
  `pass` STRING,
  `repo` STRING,
  `section` STRING,
  `service` STRING,
  `site` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/checklist/raw_json';
