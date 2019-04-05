CREATE VIEW foxsec_metrics.metadata_repo_branch AS
WITH
  interim AS (
   SELECT
     "service"
   , "json"
   FROM
     (metadata
   CROSS JOIN UNNEST("coderepositories") t (json))
   WHERE ("coderepositories" IS NOT NULL)
) 
, repo_branch AS (
   SELECT
     "service"
   , "branch"
   , "json"."url" "url"
   FROM
     (interim
   CROSS JOIN UNNEST("json"."branchestoprotect") t (branch))
) 
, legacy_repo AS (
   SELECT
     "service"
   , null "branch"
   , "url"
   FROM
     (metadata
   CROSS JOIN UNNEST("sourceControl") t (url))
) 
SELECT
  COALESCE("repo_branch"."service", "legacy_repo"."service") "service"
, "repo_branch"."branch"
, COALESCE("repo_branch"."url", "legacy_repo"."url") "url"
FROM
  (repo_branch
FULL JOIN legacy_repo ON (("repo_branch"."service" = "legacy_repo"."service") AND ("repo_branch"."url" = "legacy_repo"."url")))