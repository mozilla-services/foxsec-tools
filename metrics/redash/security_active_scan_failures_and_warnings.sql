SELECT
concat('<a href="https://sql.telemetry.mozilla.org/dashboard/security-active-scan-alert-instances?p_description_undefined=', description, '">', description, '</a>') as description,
status,
count (*) as count
FROM "foxsec_metrics"."ascan_details"
join (
    select max(ascan_details.day) as MaxDay
    from ascan_details
) md on ascan_details.day = MaxDay
where status = 'fail_new' or status = 'fail_in_progress' or status = 'warn_new' or status = 'warn_inprogress'
group by day, status, description
order by status, count DESC