SELECT site, day FROM "foxsec_metrics"."baseline_details"
join (
    select min(baseline_details.day) as MinDay,
    site as site1
    from baseline_details
    group by site
) md on baseline_details.day = MinDay and baseline_details.site = site1
group by site, day
order by day desc