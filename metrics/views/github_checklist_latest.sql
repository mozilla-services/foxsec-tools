CREATE VIEW foxsec_metrics.github_checklist_latest AS
SELECT
  'global' "environment"
, ' ' "link"
, 'Follow GitHub security standard' "item"
, CAST("protected" AS varchar) "pass"
, 'Development' "section"
, "a"."service"
, "concat"("a"."org", '/', "a"."repo") "site"
FROM
  (foxsec_metrics.default_branch_protection_status a
INNER JOIN (
   SELECT
     "service"
   , "org"
   , "repo"
   , "max"("date") "date"
   FROM
     foxsec_metrics.default_branch_protection_status
   GROUP BY "service", "org", "repo"
)  b ON (((("a"."service" = "b"."service") AND ("a"."org" = "b"."org")) AND ("a"."repo" = "b"."repo")) AND ("a"."date" = "b"."date")))
ORDER BY "service" ASC, "site" ASC