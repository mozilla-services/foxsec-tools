select 
concat(level, ' : ', text) as level_text,
count(*) as count
from foxsec_metrics_stage.lambdaguard_security

join (
    select max(foxsec_metrics_stage.lambdaguard_security.day) as MaxDay
    from foxsec_metrics_stage.lambdaguard_security
) md on foxsec_metrics_stage.lambdaguard_security.day = MaxDay
group by concat(level, ' : ', text)

