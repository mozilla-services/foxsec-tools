SELECT a.addon_id, COUNT(client_id) AS usage
FROM telemetry.clients_last_seen m CROSS JOIN UNNEST(active_addons) a
WHERE
m.submission_date = DATE_SUB(CURRENT_DATE(), INTERVAL 10 DAY) AND
days_since_seen < 15 AND
a.addon_id = "{{ guid }}" GROUP BY a.addon_id
