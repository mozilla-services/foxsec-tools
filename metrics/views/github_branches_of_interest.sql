CREATE VIEW foxsec_metrics.github_branches_of_interest AS
WITH
  repo_list AS (
   SELECT
     COALESCE("servicekey", "service") "service"
   , "repo"."status"
   , "split_part"("repo"."url", '/', 4) "Org"
   , "split_part"("split_part"("repo"."url", '/', 5), '.', 1) "Repo"
   , (CASE WHEN ("cardinality"("repo"."branchestoprotect") > 0) THEN "repo"."branchestoprotect" ELSE ARRAY[null] END) "branchestoprotect2"
   FROM
     (metadata
   CROSS JOIN UNNEST("coderepositories") t (repo))
   WHERE ("repo"."hostingservice" = 'GitHub')
)
SELECT DISTINCT
  "service"
, "status"
, "org"
, "repo"
, "branch"
FROM
  (repo_list
CROSS JOIN UNNEST("branchestoprotect2") t (branch))
