select wsec, count(*) as COUNT from foxsec_metrics.security_bugs
where 
    resolution != 'INVALID' and
    resolution != 'DUPLICATE' and
    wsec != ''
group by wsec
