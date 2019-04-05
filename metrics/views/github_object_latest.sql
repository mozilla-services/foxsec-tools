CREATE VIEW foxsec_metrics.github_object_latest AS
SELECT
  "body"
, "date"
, "rc"
, "url"
, "when"
FROM
  (github_object
INNER JOIN (
   SELECT "max"("date") "MaxDay"
   FROM
     github_object
)  md ON ("github_object"."date" = "MaxDay"))