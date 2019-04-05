SELECT foxsec_metrics.baseline_sites.day,
       sum(CASE
               WHEN urlcount < 4 THEN 1
               ELSE 0
           END) nothing,
       sum(CASE
               WHEN urlcount >= 4 and urlcount < 10 THEN 1
               ELSE 0
           END) low,
       sum(CASE
               WHEN urlcount >= 10 and urlcount < 100 THEN 1
               ELSE 0
           END) medium,
       sum(CASE
               WHEN urlcount >= 100 THEN 1
               ELSE 0
           END) high
FROM foxsec_metrics.baseline_sites
GROUP BY foxsec_metrics.baseline_sites.day
ORDER BY foxsec_metrics.baseline_sites.day ASC;
