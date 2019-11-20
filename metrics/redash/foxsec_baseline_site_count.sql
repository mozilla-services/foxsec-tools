select day, count(*) as sites from foxsec_metrics.baseline_sites
where date(day) > current_date - interval '1' month
group by day
order by day