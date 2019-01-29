CREATE VIEW foxsec_metrics.all_default_branch_protection_status_latest AS
SELECT
  "body"."name" "Name"
, "body"."protected" "Protected"
, "URL"
, "split_part"("url", '/', 3) "Org"
, "split_part"("url", '/', 4) "Repo"
, "split_part"("url", '/', 6) "Branch"
, "date"
FROM
  (github_object
INNER JOIN (
   SELECT "max"("date") "MaxDay"
   FROM
     github_object
)  md ON ("github_object"."date" = "MaxDay"))
WHERE ("body"."protected" IS NOT NULL)