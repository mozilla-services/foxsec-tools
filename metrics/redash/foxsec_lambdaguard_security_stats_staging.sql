select day, level,
count(*) as count
from foxsec_metrics_stage.lambdaguard_security
group by day, level