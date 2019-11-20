select
EXTRACT(DATE from timestamp) as date,
case value
when 'addons.mozilla.org' then 
    (SELECT value FROM UNNEST(metadata) WHERE key = 'amo_category')
when 'accounts.firefox.com' then 
    (SELECT value FROM UNNEST(metadata) WHERE key = 'customs_category')
else
    (SELECT value FROM UNNEST(metadata) WHERE key = 'category')
end as category,
count(*) as count
from alerts_metrics.alerts_metrics
CROSS JOIN UNNEST (metadata) as metadata_unnest
where key = 'monitored_resource'
and value = 'bugzilla.mozilla.org'
AND timestamp > TIMESTAMP_SUB(CURRENT_TIMESTAMP(), INTERVAL 30 DAY)
group by date, category
