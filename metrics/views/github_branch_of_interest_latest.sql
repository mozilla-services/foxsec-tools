CREATE VIEW foxsec_metrics.github_branch_of_interest_latest AS
SELECT
  "mdi"."service"
, "mdi"."org"
, "mdi"."repo"
, "body"
, "date"
, "rc"
, "url"
, "when"
FROM
  (github_branch_latest
INNER JOIN metadata_repo_parsed mdi ON ("github_branch_latest"."url" LIKE "concat"('/repos/', "mdi"."org", '/', "mdi"."repo", '/%')))