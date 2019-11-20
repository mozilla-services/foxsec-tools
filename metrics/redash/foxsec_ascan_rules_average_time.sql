select day, name, avg(timems)/1000 as timems from foxsec_metrics.ascan_progress
group by day, name