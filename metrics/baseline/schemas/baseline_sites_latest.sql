CREATE EXTERNAL TABLE IF NOT EXISTS baseline_sites_latest (
  `day` STRING,
  `fail_in_progress` INT,
  `fail_new` INT,
  `ignore_new` INT,
  `info_new` INT,
  `pass` INT,
  `service` STRING,
  `site` STRING,
  `status` STRING,
  `urlCount` INT,
  `warn_new` INT
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/baseline/sites_latest_json/';
