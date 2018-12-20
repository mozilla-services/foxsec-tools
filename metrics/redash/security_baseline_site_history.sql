select day, 
concat('<a href="https://sql.telemetry.mozilla.org/dashboard/security-baseline-site-scores?p_day_60202=', day, '&p_site_60202=', site, '">', site, '</a>') as site,
urlcount, 
COALESCE(fail_in_progress,0) + COALESCE(fail_new,0) as failures,
case 
when COALESCE(urlcount,0) = 0 then '<div class="bg-warning p-10 text-center">Unavailable</div>'
when status = 'pass' then '<div class="bg-success p-10 text-center">Pass</div>' 
else '<div class="bg-danger p-10 text-center">Fail</div>' end pass
from foxsec_metrics.baseline_sites
where site = '{{ site }}'
order by day  desc