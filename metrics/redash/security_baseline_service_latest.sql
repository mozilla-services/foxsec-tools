SELECT description, failingurls, 
concat('<a href="', progresslink, '">', progresslink, '</a>') as progresslink,
case status 
    when 'pass' then '<div class="bg-success p-10 text-center">Pass</div>' 
    when 'info_new' then '<div class="bg-success p-10 text-center">Info</div>' 
    when 'warn_new' then '<div class="bg-warning p-10 text-center">Warning</div>' 
    when 'warn_in_progress' then '<div class="bg-warning p-10 text-center">Warning</div>' 
    when 'ignore_new' then '<div class="bg-success p-10 text-center">Ignore</div>' 
    else '<div class="bg-danger p-10 text-center">Fail</div>' end pass
FROM "foxsec_metrics"."baseline_details" 
join (
    select max(baseline_details.day) as MaxDay
    from baseline_details
) md on baseline_details.day = MaxDay
where site = '{{ site }}'
ORDER BY (CASE WHEN status = 'fail_new' THEN 0
	       WHEN status = 'fail_in_progress' THEN 1
	       WHEN status = 'warn_new' THEN 2
	       WHEN status = 'warn_in_progress' THEN 3
	       WHEN status = 'pass' THEN 4 END)