CREATE OR REPLACE VIEW github_default_branch_protection_status AS 
SELECT
  "Protected"
, "Service"
, "meta"."org" "Org"
, "meta"."repo" "Repo"
, "branch"."branch" "Branch"
, "date"
FROM
  (metadata_repo_parsed meta
INNER JOIN github_default_branch_protection_status_all branch ON (("meta"."org" = "branch"."org") AND ("meta"."repo" = "branch"."repo")))

