CREATE VIEW foxsec_metrics.security_bugs_all_flags AS
SELECT
  "id"
, "flag"
FROM
  (foxsec_metrics.security_bugs_all
CROSS JOIN UNNEST("flags") t (flag))