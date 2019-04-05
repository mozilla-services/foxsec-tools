-- Simple count of passes, but only for repos we care about.
With
latest as (
SELECT
    Date,
    Protected
FROM foxsec_metrics.default_branch_protection_status
JOIN
     (SELECT max(default_branch_protection_status.date) AS MaxDay
      FROM default_branch_protection_status) md ON default_branch_protection_status.date = MaxDay)
select
    case
    when Protected then 'Pass'
    else 'Not Compliant'
    end as status,
    count(*) as percent
    
from latest
group by protected
