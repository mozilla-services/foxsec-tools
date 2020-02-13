CREATE EXTERNAL TABLE IF NOT EXISTS metadata_services (
  `appCode` STRING,
  `risk` STRING,
  `riskSummary` STRING,
  `rra` STRING,
  `rraData` STRING,
  `rraDate` STRING,
  `rraImpact` STRING,
  `service` STRING,
  `serviceKey` STRING,
  `awsAppTags` ARRAY<STRING>
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/metadata/metadata_services_json/';
