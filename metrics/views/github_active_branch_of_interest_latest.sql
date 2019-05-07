CREATE VIEW foxsec_metrics.github_active_branch_of_interest_latest AS
SELECT
  "branch"."service"
, "branch"."org"
, "branch"."repo"
, "branch"."body"."name" "branch"
, "branch"."date"
, "branch"."body"
FROM
  (github_branch_of_interest_latest branch
INNER JOIN github_repo_of_interest_latest repo ON ("branch"."url" LIKE "concat"("repo"."url", '/%')))
WHERE ("repo"."body"."archived" = false)