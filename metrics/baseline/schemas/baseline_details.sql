CREATE EXTERNAL TABLE IF NOT EXISTS baseline_details (
  `day` STRING,
  `description` STRING,
  `failingUrls` STRING,
  `progressLink` STRING,
  `rule` STRING,
  `site` STRING,
  `status` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/baseline/details_json/';
