SELECT
 site,
 failingurls, 
 concat('<a href="', progresslink, '">', progresslink, '</a>') as progresslink
FROM "foxsec_metrics"."ascan_details"
join (
    select max(ascan_details.day) as MaxDay
    from ascan_details
) md on ascan_details.day = MaxDay
where (status = 'fail_new' or status = 'fail_in_progress' or status = 'warn_new' or status = 'warn_inprogress')
and description = '{{ description }}'
