SELECT account,
       test_name,
       count(*)
FROM foxsec_metrics.aws_pytest_services
WHERE date(foxsec_metrics.aws_pytest_services.day) > (NOW() - INTERVAL '2' DAY)
  AND status='fail'
GROUP BY foxsec_metrics.aws_pytest_services.day,
         account,
         test_name