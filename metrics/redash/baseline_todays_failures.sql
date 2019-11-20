SELECT
concat('<a href="https://sql.telemetry.mozilla.org/dashboard/security-baseline-alert-instances?p_description_undefined=', description, '">', description, '</a>') as description,
count (*) as count
FROM "foxsec_metrics"."baseline_details"
join (
    select max(baseline_details.day) as MaxDay
    from baseline_details
) md on baseline_details.day = MaxDay
where status = 'fail_new' or status = 'fail_in_progress'
group by day, description
order by count DESC