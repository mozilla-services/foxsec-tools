CREATE EXTERNAL TABLE IF NOT EXISTS metadata_urls (
  `appCode` STRING,
  `category` STRING,
  `path` STRING,
  `qualifier` STRING,
  `service` STRING,
  `serviceKey` STRING,
  `status` STRING,
  `url` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/metadata/metadata_urls_json/';
