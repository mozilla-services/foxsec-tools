select 
concat('<a href="https://sql.telemetry.mozilla.org/dashboard/foxsec-fraud-alerts-for-service-by-category?p_site_64402=', value, '">', value, '</a>') as site,
count(*) as count 
from alerts_metrics.alerts_metrics
CROSS JOIN UNNEST (metadata) as metadata_unnest
where key = 'monitored_resource'
group by site
order by site
