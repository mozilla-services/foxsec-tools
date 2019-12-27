CREATE VIEW foxsec_metrics.all_default_branch_protection_status AS
WITH
  active_repos AS (
   SELECT
     "url" "Prefix"
   , "date"
   FROM
     foxsec_metrics.github_object
   WHERE (("body"."archived" IS NOT NULL) AND ("body"."archived" = false))
) 
SELECT
  "body"."name" "Name"
, "body"."protected" "Protected"
, "url"
, "split_part"("url", '/', 3) "Org"
, "split_part"("url", '/', 4) "Repo"
, "split_part"("url", '/', 6) "Branch"
, "branch"."date"
FROM
  (foxsec_metrics.github_object branch
LEFT JOIN active_repos ON (("active_repos"."date" = "branch"."date") AND ("strpos"("branch"."url", "active_repos"."prefix") = 1)))
WHERE ("body"."protected" IS NOT NULL)