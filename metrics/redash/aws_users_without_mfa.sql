
SELECT foxsec_metrics.aws_pytest_services.day,
       account,
       sum(CASE
               WHEN status = 'fail' THEN 1
               ELSE 0
           END) fail,
       sum(CASE
               WHEN status = 'warn' THEN 1
               ELSE 0
           END) warn,
       sum(CASE
               WHEN status = 'pass' THEN 1
               ELSE 0
           END) pass
FROM foxsec_metrics.aws_pytest_services
WHERE test_name = 'test_iam_user_without_mfa'
  AND date(foxsec_metrics.aws_pytest_services.day) > (CURRENT_DATE - interval '2' MONTH)
GROUP BY foxsec_metrics.aws_pytest_services.day,
         account
ORDER BY foxsec_metrics.aws_pytest_services.day ASC;