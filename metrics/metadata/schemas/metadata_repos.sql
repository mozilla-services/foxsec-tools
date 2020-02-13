CREATE EXTERNAL TABLE IF NOT EXISTS metadata_repos (
  `appCode` STRING,
  `repo` STRING,
  `service` STRING,
  `serviceKey` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/metadata/metadata_repos_json/';
