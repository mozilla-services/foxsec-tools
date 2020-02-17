CREATE EXTERNAL TABLE IF NOT EXISTS inventory_application_component (
  `appCode` STRING,
  `appCompCode` STRING,
  `appCompName` STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
LOCATION 's3://foxsec-metrics/inventory/inventory_appplication_component_csv/';
