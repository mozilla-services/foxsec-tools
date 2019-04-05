CREATE VIEW foxsec_metrics.github_repo_of_interest_latest AS
SELECT
  "body"
, "date"
, "rc"
, "url"
, "when"
FROM
  (github_repo_latest
INNER JOIN metadata_repo_parsed mdi ON ("github_repo_latest"."url" = "concat"('/repos/', "mdi"."org", '/', "mdi"."repo")))