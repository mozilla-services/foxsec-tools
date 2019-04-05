CREATE VIEW foxsec_metrics.github_active_branch_of_interest_latest AS
SELECT
  "branch"."body"
, "branch"."date"
, "branch"."rc"
, "branch"."url"
, "branch"."when"
FROM
  (github_branch_of_interest_latest branch
INNER JOIN github_repo_of_interest_latest repo ON ("branch"."url" LIKE "concat"("repo"."url", '/%')))
WHERE ("repo"."body"."archived" = false)
LIMIT 10