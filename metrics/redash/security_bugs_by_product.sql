select service, count(*) as COUNT from foxsec_metrics.security_bugs
where 
    resolution != 'INVALID' and
    resolution != 'DUPLICATE'
group by service