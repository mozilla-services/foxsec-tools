CREATE OR REPLACE VIEW github_default_branch_protection_status_all AS 
SELECT
  "body"."name" "Name"
, "body"."protected" "Protected"
, "URL"
, "split_part"("url", '/', 3) "Org"
, "split_part"("url", '/', 4) "Repo"
, "split_part"("url", '/', 5) "Branch"
, "date"
FROM
  github_object
WHERE ("body"."protected" IS NOT NULL)
