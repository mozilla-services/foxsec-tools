CREATE VIEW foxsec_metrics.metadata_repo_parsed AS
SELECT
  "split_part"("repo", '/', 3) "Host"
, "split_part"("repo", '/', 4) "Org"
, "replace"("split_part"("repo", '/', 5), '.git') "Repo"
, "service" "Service"
, "appCode" "appCode"
FROM
  foxsec_metrics.metadata_repos
