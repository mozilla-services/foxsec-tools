CREATE VIEW foxsec_metrics.security_bugs_all_groups AS
SELECT
  "id"
, "grp"
FROM
  (foxsec_metrics.security_bugs_all
CROSS JOIN UNNEST("groups") t (grp))