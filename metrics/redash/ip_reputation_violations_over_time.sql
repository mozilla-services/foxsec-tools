SELECT DAY,
       field,
       sum(value) AS total
FROM "foxsec_metrics"."fraud"
WHERE category IN ('iprepd_alerts')
  AND field NOT IN ('total_count',
                    'violation_exceptions',
                    'violation_applied')
GROUP BY DAY,
         field
ORDER BY DAY,
         field,
         total