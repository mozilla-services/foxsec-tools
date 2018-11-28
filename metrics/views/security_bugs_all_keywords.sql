CREATE VIEW foxsec_metrics.security_bugs_all_keywords AS
SELECT
  "id"
, "keyword"
FROM
  (foxsec_metrics.security_bugs_all
CROSS JOIN UNNEST("keywords") t (keyword))