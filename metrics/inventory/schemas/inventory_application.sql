CREATE EXTERNAL TABLE IF NOT EXISTS inventory_application (
  `appCode` STRING,
  `appName` STRING,
  `program` STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
LOCATION 's3://foxsec-metrics/inventory/inventory_appplication_csv/';
