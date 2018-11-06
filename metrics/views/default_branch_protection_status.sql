CREATE VIEW foxsec_metrics.default_branch_protection_status AS
SELECT
  "Protected"
, "Service"
, "meta"."org" "Org"
, "meta"."repo" "Repo"
, "branch"."branch" "Branch"
, "date"
FROM
  (metadata_repo_parsed meta
INNER JOIN all_default_branch_protection_status branch ON (("meta"."org" = "branch"."org") AND ("meta"."repo" = "branch"."repo")))