-- Report on all repositories which have never been set
 -- Current Unprotected Repositories/Branches
 WITH latestRecord AS

  (SELECT date, service,
                org,
                repo,
                branch,
                protected
   FROM foxsec_metrics.github_production_branch_protection_status
   JOIN
     (SELECT max(github_production_branch_protection_status.date) AS MaxDay
      FROM github_production_branch_protection_status) md ON github_production_branch_protection_status.date = MaxDay
   WHERE github_production_branch_protection_status.protected = FALSE ), 
   
-- Repositories that have never been protected
   everProtected AS
  (SELECT 
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
      WHERE protected = FALSE
      GROUP BY service,
               org,
               repo ) AS b ON a.service = b.service
   AND a.org = b.org
   AND a.repo = b.repo
   AND a.date = b.date )
   
-- Find the repositories which have not regressed
SELECT
       latestRecord.org,
       latestRecord.repo,
       latestRecord.branch,
       latestRecord.service,
       latestRecord.protected,
       concat('https://github.com/', latestRecord.org, '/', latestRecord.repo, '/settings/branches') as "Admin Link"
FROM latestRecord
INNER JOIN everProtected ON (everProtected.service = latestRecord.service
                             AND everProtected.org = latestRecord.org
                             AND everProtected.repo = latestRecord.repo)
ORDER BY org asc, repo asc