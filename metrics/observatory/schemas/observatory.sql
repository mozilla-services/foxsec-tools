CREATE EXTERNAL TABLE IF NOT EXISTS observatory (
  `day` STRING,
  `observatory_score` INT,
  `service` STRING,
  `site` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/observatory/raw_json/';
