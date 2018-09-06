CREATE EXTERNAL TABLE IF NOT EXISTS metadata_services (
  `riskSummary` STRING,
  `rra` STRING,
  `rraData` STRING,
  `rraDate` STRING,
  `rraImpact` STRING,
  `service` STRING,
  `serviceKey` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/metadata/metadata_services_json/';
