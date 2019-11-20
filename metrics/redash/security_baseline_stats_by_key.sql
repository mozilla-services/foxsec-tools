SELECT
 concat('<a href="https://sql.telemetry.mozilla.org/dashboard/security-baseline-stats-for-key_1?p_key_undefined=', key,
'">', key, '</a>') as key,
 count(*) as count
FROM "foxsec_metrics"."baseline_stats"
join (
    select max(baseline_stats.day) as MaxDay
    from baseline_stats
) md on baseline_stats.day = MaxDay
group by key
order by key