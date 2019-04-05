CREATE VIEW foxsec_metrics.github_array_latest AS
SELECT
  "body"
, "date"
, "rc"
, "url"
, "when"
FROM
  (github_array
INNER JOIN (
   SELECT "max"("date") "MaxDay"
   FROM
     github_array
)  md ON ("github_array"."date" = "MaxDay"))