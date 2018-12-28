CREATE EXTERNAL TABLE IF NOT EXISTS foxsec_metrics.heroku_members (
  `created_at` string,
  `date` string,
  `email` string,
  `federated` boolean,
  `id` string,
  `role` string,
  `status` string,
  `two_factor_authentication` boolean,
  `updated_at` string,
  `user` struct<
    email:string,
    id:string,
    name:string>)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = '1'
) LOCATION 's3://foxsec-metrics/heroku/members_json/'
TBLPROPERTIES ('has_encrypted_data'='false');
