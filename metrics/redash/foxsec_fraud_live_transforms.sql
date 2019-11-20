WITH latest AS (
  SELECT
  MAX(timestamp) AS ts, (SELECT value FROM UNNEST(metadata) WHERE key = 'monitored_resource') AS mr
  FROM `alerts_metrics.alerts_metrics`
  WHERE category = 'httprequest-cfgtick'
  GROUP BY mr
  ORDER BY ts DESC
)
SELECT id, latest.ts, latest.mr, key, value FROM latest
JOIN `alerts_metrics.alerts_metrics` a ON (a.timestamp = latest.ts)
CROSS JOIN UNNEST(a.metadata) ON (key LIKE 'heuristic%')
ORDER BY latest.mr