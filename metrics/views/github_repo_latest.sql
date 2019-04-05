CREATE VIEW foxsec_metrics.github_repo_latest AS
SELECT *
FROM
  github_object_latest
WHERE ("body"."archived" IS NOT NULL)