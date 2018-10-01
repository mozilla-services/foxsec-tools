CREATE EXTERNAL TABLE `github_array`(
  `body` array<struct<
      days:array<int>,
      total:int,
      week:int>> COMMENT 'from deserializer', 
  `date` string COMMENT 'from deserializer', 
  `rc` int COMMENT 'from deserializer', 
  `url` string COMMENT 'from deserializer', 
  `when` struct<
    etag:string,last_modified:string> COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.apache.hive.hcatalog.data.JsonSerDe' 
WITH SERDEPROPERTIES ( 
  'ignore.malformed.json'='true', 
  'mapping.NC__links'='_links', 
  'mapping.NC_following'='following', 
  'mapping.last_modified'='last-modified') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://foxsec-metrics/github/array_json'
