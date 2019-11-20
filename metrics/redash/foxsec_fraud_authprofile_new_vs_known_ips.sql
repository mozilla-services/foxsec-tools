SELECT 
CASE 
WHEN severity = 'info' THEN 'Known IP'
WHEN severity = 'warn' THEN 'New IP'
END as ip_address,
extract(DATE from timestamp) as day, 
count(*) as count FROM alerts_metrics.alerts_metrics 
WHERE category = 'authprofile' AND EXISTS (SELECT 1 FROM UNNEST(metadata) 
WHERE key = 'category' AND value = 'state_analyze')
GROUP BY day, ip_address