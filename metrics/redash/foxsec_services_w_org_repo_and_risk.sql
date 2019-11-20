WITH gh AS
  (SELECT service,
          org,
          repo
   FROM foxsec_metrics.github_active_branch_of_interest_latest
   WHERE date(Date) > (NOW() - INTERVAL '2' DAY)
   GROUP BY service,
            org,
            repo)
SELECT meta.service,
       org,
       repo,
       risk
FROM foxsec_metrics.metadata_services AS meta
INNER JOIN gh ON meta.service = gh.service
ORDER BY risk,
         service ASC