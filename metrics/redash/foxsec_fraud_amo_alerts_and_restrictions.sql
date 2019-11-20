SELECT EXTRACT(DATE from timestamp) as date,
SUM(CASE WHEN EXISTS (SELECT 1 FROM UNNEST(metadata) WHERE key = 'amo_category' AND value != 'amo_restriction') THEN 1 ELSE 0 END) AS alerts,
SUM(CASE WHEN EXISTS (SELECT 1 FROM UNNEST(metadata) WHERE key = 'amo_category' AND value = 'amo_restriction') THEN 1 ELSE 0 END) AS restrictions
FROM alerts_metrics.alerts_metrics
WHERE category = 'amo'
AND timestamp > TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1440 HOUR)
GROUP BY date
ORDER BY date desc