select day, count(*) as sites from foxsec_metrics.ascan_sites
where date(day) > current_date - interval '3' month
group by day
order by day