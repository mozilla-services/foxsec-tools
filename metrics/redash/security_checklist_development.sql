select service, section, 
concat('<a href="https://sql.telemetry.mozilla.org/dashboard/firefox-secops-checklist-details?p_service_59954=', service, '&p_environment_59954=development&p_item_59955=', item, '">', item, '</a>') as item,
passes,
failures,
case failures when 0 then '<div class="bg-success p-10 text-center">Pass</div>' else '<div class="bg-danger p-10 text-center">Fail</div>' end pass from foxsec_metrics.checklist_item_rollup
where service = '{{service}}' and environment = 'development'
order by section, item
