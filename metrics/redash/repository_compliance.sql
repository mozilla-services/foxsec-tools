-- Simple count of passes, but only for repos we care about.
SELECT
Date,
    count_if( Protected) as "Pass",
    count_if( not Protected) as "Unprotected",
     
    count(*) AS "Total"
FROM foxsec_metrics.default_branch_protection_status
GROUP BY Date
-- order for table view only
ORDER BY Date DESC