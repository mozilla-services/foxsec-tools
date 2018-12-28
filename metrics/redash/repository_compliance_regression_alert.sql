-- fork from repository compliance regression
-- should be pushed back to Athena
-- Report on all repositories which have regressed
 -- Current Unprotected Repositories
 WITH latestRecord AS

  (SELECT date, service,
                org,
                repo,
                branch,
                protected
   FROM foxsec_metrics.default_branch_protection_status
   JOIN
     (SELECT max(default_branch_protection_status.date) AS MaxDay
      FROM default_branch_protection_status) md ON default_branch_protection_status.date = MaxDay
   WHERE default_branch_protection_status.protected = FALSE ), 
   
-- Repositories that were protected at one time
   everProtected AS
  (SELECT a.date AS "Last Protected",
          a.service,
          a.org,
          a.repo,
          a.branch
   FROM "foxsec_metrics"."default_branch_protection_status" AS a
   INNER JOIN
     ( SELECT service,
              org,
              repo,
              max(date) AS date
      FROM "foxsec_metrics"."default_branch_protection_status"
      WHERE protected = TRUE
      GROUP BY service,
               org,
               repo ) AS b ON a.service = b.service
   AND a.org = b.org
   AND a.repo = b.repo
   AND a.date = b.date ),

regressed as (
   
-- Find the repositories which have regressed
SELECT latestRecord.service,
       latestRecord.org,
       latestRecord.repo,
       latestRecord.branch,
       "Last Protected"
FROM latestRecord
INNER JOIN everProtected ON (everProtected.service = latestRecord.service
                             AND everProtected.org = latestRecord.org
                             AND everProtected.repo = latestRecord.repo))
Select count(*) as badCount from regressed
