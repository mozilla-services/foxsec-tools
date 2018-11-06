CREATE VIEW foxsec_metrics.sb-test-view AS
SELECT *
FROM
  foxsec_metrics.aws_pytest_services
LIMIT 10