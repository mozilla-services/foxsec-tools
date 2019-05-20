CREATE VIEW foxsec_metrics.github_production_branch_protection_status_latest AS
SELECT
  "Protected"
, "Service"
, "meta"."org" "Org"
, "meta"."repo" "Repo"
, "branch"."branch" "Branch"
, "date"
FROM
  (foxsec_metrics.metadata_repo_parsed meta
INNER JOIN foxsec_metrics.all_default_branch_protection_status_latest branch ON (("meta"."org" = "branch"."org") AND ("meta"."repo" = "branch"."repo")))