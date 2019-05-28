-- Report on all repositories which have regressed
-- excluding archived repos
 WITH 
-- Repositories that were protected at one time
   everProtected AS
  (SELECT a.date AS "Last Protected",
          a.service,
          a.org,
          a.repo,
          a.branch
   FROM "foxsec_metrics"."github_production_branch_protection_status" AS a
   INNER JOIN
     ( SELECT service,
              org,
              repo,
              max(date) AS date
      FROM "foxsec_metrics"."github_production_branch_protection_status"
      WHERE protected = TRUE
      GROUP BY service,
               org,
               repo ) AS b ON a.service = b.service
   AND a.org = b.org
   AND a.repo = b.repo
   AND a.date = b.date )
   
-- Find the repositories which have regressed
SELECT latestRecord.service,
       latestRecord.org,
       latestRecord.repo,
       latestRecord.branch,
       "Last Protected"
FROM github_active_branch_of_interest_latest as latestRecord
INNER JOIN everProtected ON (everProtected.service = latestRecord.service
                             AND everProtected.org = latestRecord.org
                             AND everProtected.repo = latestRecord.repo)
WHERE
    (latestRecord.body.protected is not null) and (latestRecord.body.protected = False)
ORDER BY everProtected."Last Protected" ASC ;