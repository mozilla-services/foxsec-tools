SELECT service, org, repo
FROM foxsec_metrics.github_active_branch_of_interest_latest
WHERE date(Date) > (NOW() - INTERVAL '2' DAY)
GROUP BY service, org, repo