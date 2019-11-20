select extract(DATE from timestamp) as day, count(*) as count from alerts_metrics.alerts_metrics
where category = "customs"
group by day
