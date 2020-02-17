CREATE EXTERNAL TABLE IF NOT EXISTS foxsec_metrics.metadata (
  `appCode` STRING,
  `audits` array<struct<
      auditor:string,
      date:string,
      link:string,
      status:string,
      tracker:string>>,
  `awsAppTags` array<string>,
  `bugzilla` array<struct<
      component:string,
      product:string>>,
  `checklists` array<string>,
  `codeRepositories` array<struct<
      branchesToProtect:array<string>,
      comment:string,
      hostingService:string,
      status:string,
      url:string,
      vcs:string>>,
  `contact` string,
  `dockerImageURLs` array<string>,
  `hostingProvider` array<struct<
      env:string,
      id:string,
      type:string>>,
  `notes` string,
  `risk` string,
  `riskSummary` string,
  `rra` string,
  `rraData` string,
  `rraDate` string,
  `rraImpact` string,
  `security` string,
  `seeAlso` array<string>,
  `service` string,
  `serviceKey` string,
  `sites` array<struct<
      category:string,
      comment:string,
      riskSummary:string,
      rra:string,
      site:string,
      urls:array<struct<
          baselineScanConf:string,
          comment:string,
          exceptions:array<string>,
          path:string,
          qualifier:string,
          special:string,
          status:string,
          url:string>>>>,
  `sourceControl` array<string>,
  `version` int
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES (
  'serialization.format' = '1'
) LOCATION 's3://foxsec-metrics/metadata/metadata_json/'
TBLPROPERTIES ('has_encrypted_data'='false');
