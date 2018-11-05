
SELECT foxsec_metrics.aws_pytest_services.day,
       sum(CASE
               WHEN foxsec_metrics.aws_pytest_services.status = 'fail' THEN 1
               ELSE 0
           END) fail,
       sum(CASE
               WHEN foxsec_metrics.aws_pytest_services.status = 'warn' THEN 1
               ELSE 0
           END) warn,
       sum(CASE
               WHEN foxsec_metrics.aws_pytest_services.status = 'pass' THEN 1
               ELSE 0
           END) pass
FROM foxsec_metrics.aws_pytest_services
GROUP BY foxsec_metrics.aws_pytest_services.day
ORDER BY foxsec_metrics.aws_pytest_services.day ASC;