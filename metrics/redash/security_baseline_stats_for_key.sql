SELECT
 site,
 --key,
 sum(value) as sum
FROM "foxsec_metrics"."baseline_stats"
join (
    select max(baseline_stats.day) as MaxDay
    from baseline_stats
) md on baseline_stats.day = MaxDay
where key = '{{key}}'
group by site
order by site
