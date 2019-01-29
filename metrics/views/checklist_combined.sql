CREATE VIEW foxsec_metrics.checklist_combined AS
SELECT *
FROM
  checklist
UNION ALL SELECT *
FROM
  github_checklist_latest