SELECT
EXTRACT(DATE from timestamp) AS date,
COUNT((SELECT DISTINCT value FROM UNNEST(metadata) WHERE key = 'sourceaddress')) AS unique_sourceaddresses
FROM `alerts_metrics.alerts_metrics`
WHERE timestamp >= TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 1440 HOUR)
AND category = 'amo'
AND EXISTS (SELECT 1 FROM UNNEST(metadata) WHERE key = 'amo_category' AND value = 'amo_restriction')
GROUP BY date
ORDER BY date DESC