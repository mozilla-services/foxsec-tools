WITH latest AS (
  SELECT
  MAX(timestamp) AS ts, category, (SELECT value FROM UNNEST(metadata) WHERE key = 'monitored_resource') AS mr
  FROM `alerts_metrics.alerts_metrics`
  WHERE category LIKE '%-cfgtick'
  GROUP BY mr, category
  ORDER BY ts DESC
)
SELECT id, latest.ts, latest.mr, key, value FROM latest
JOIN `alerts_metrics.alerts_metrics` a ON (a.timestamp = latest.ts)
CROSS JOIN UNNEST(a.metadata) ON (key LIKE 'heuristic%')
WHERE mr = '{{ site }}'
ORDER BY latest.mr