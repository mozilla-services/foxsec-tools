select value, extract(DATE from timestamp) as day, count(*) as count from alerts_metrics.alerts_metrics
CROSS JOIN UNNEST (metadata) as metadata_unnest
where category = 'httprequest' and key = 'category'
group by day, value