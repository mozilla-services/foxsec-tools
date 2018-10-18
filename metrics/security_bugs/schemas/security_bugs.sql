CREATE EXTERNAL TABLE IF NOT EXISTS security_bugs (
  `bug_bounty` STRING,
  `bugid` INT,
  `creation_day` STRING,
  `last_change_day` STRING,
  `resolution` STRING,
  `sec` STRING,
  `sec_group` STRING,
  `service` STRING,
  `status` STRING,
  `wsec` STRING
)
ROW FORMAT  serde 'org.openx.data.jsonserde.JsonSerDe'
LOCATION 's3://foxsec-metrics/security_bugs/raw_json/';