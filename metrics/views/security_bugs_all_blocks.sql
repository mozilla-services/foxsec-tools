CREATE VIEW foxsec_metrics.security_bugs_all_blocks AS
SELECT
  "id"
, "block"
FROM
  (foxsec_metrics.security_bugs_all
CROSS JOIN UNNEST("blocks") t (block))