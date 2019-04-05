select service, section, item, site, 
case when LENGTH(link) > 0 then concat('<a href="', link, '">link</a>') else '' end link,
case pass when 'true' then '<div class="bg-success p-10 text-center">Pass</div>' else '<div class="bg-danger p-10 text-center">Fail</div>' end pass from foxsec_metrics.checklist_combined
where service = '{{service}}' and environment = '{{environment}}' and item = '{{item}}'
order by section, item