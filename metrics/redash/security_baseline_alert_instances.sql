SELECT
 concat('<a href="https://sql.telemetry.mozilla.org/dashboard/security-baseline-site-history?p_site_60205=', site, '">', site, '</a>') as site,
 failingurls, 
 concat('<a href="', progresslink, '">', progresslink, '</a>') as progresslink
FROM "foxsec_metrics"."baseline_details"
join (
    select max(baseline_details.day) as MaxDay
    from baseline_details
) md on baseline_details.day = MaxDay
where (status = 'fail_new' or status = 'fail_in_progress' or status = 'warn_new' or status = 'warn_inprogress')
and description = '{{ description }}'
