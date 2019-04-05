SELECT service,
       count(distinct(repo)) AS "Failures count",
       array_join(array_agg(distinct(repo)), ',') AS "Failing repositories"
FROM foxsec_metrics.default_branch_protection_status
WHERE Protected = FALSE
  AND date(Date) > (NOW() - INTERVAL '2' DAY)
GROUP BY service
ORDER BY count(distinct(repo)) DESC;