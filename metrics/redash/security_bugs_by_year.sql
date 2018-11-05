select 
    SUBSTRING(creation_day, 1, 4) AS year, 
    count(*) as COUNT from foxsec_metrics.security_bugs
where 
    resolution != 'INVALID' and
    resolution != 'DUPLICATE'
group by SUBSTRING(creation_day, 1, 4)
order by year