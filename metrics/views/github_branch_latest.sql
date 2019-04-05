CREATE VIEW foxsec_metrics.github_branch_latest AS
SELECT *
FROM
  github_object_latest
WHERE ("body"."protected" IS NOT NULL)