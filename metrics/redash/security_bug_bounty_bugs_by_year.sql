select 
    SUBSTRING(creation_day, 1, 4) AS year, 
    bug_bounty,
    count(*) as COUNT from foxsec_metrics.security_bugs
where 
    resolution != 'INVALID' and
    resolution != 'DUPLICATE' and
    bug_bounty = '+'
group by SUBSTRING(creation_day, 1, 4), bug_bounty
order by year