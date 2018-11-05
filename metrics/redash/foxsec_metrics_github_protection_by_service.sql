SELECT date, service,
       every(protected) AS service_protection
FROM foxsec_metrics.default_branch_protection_status
JOIN
  (SELECT max(default_branch_protection_status.date) AS MaxDay
   FROM default_branch_protection_status) md ON default_branch_protection_status.date = MaxDay
GROUP BY (date, service)
ORDER by service 
;