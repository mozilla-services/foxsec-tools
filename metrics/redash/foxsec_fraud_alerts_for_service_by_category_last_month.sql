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
and value = '{{ site }}'
and ('cfgtick' !=
  case value
  when 'addons.mozilla.org' then 
      (SELECT value FROM UNNEST(metadata) WHERE key = 'amo_category')
  when 'accounts.firefox.com' then 
      (SELECT value FROM UNNEST(metadata) WHERE key = 'customs_category')
  else
      (SELECT value FROM UNNEST(metadata) WHERE key = 'category')
  end)
and TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), timestamp, DAY) <= 31
group by date, category