select category, extract(DATE from timestamp) as day, count(*) as count from alerts_metrics.alerts_metrics
group by category, day