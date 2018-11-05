SELECT b.date,
       a.service,
       every(b.body.two_factor_requirement_enabled) AS "2FA"
FROM foxsec_metrics.metadata_repo_parsed AS a,
     foxsec_metrics.github_object AS b
JOIN
  (SELECT max(b2.date) AS MaxDay
   FROM foxsec_metrics.github_object as b2) ON b.date = MaxDay
WHERE (b.body.two_factor_requirement_enabled IS NOT NULL)
GROUP BY (date, service)
ORDER BY "2FA", service ;