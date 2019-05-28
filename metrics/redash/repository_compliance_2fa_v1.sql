-- Extract Organizations 2FA status
-- it's not a boolean, as it could be unavailable
WITH 
-- We only care about current status
latestRecord AS
  (SELECT date, body
   FROM github_object
   JOIN
     (SELECT max(github_object.date) AS MaxDay
      FROM github_object) md ON github_object.date = MaxDay
   -- make sure we're working with an org record
   WHERE body.has_organization_projects is not null ),
-- From orgs we're actively monitoring
orgsOfInterest AS
   (SELECT 
  "split_part"("repo", '/', 4) "Org"
   from foxsec_metrics.metadata_repos)
 

-- only report once per org
 select distinct
 date,
 body.login as "Organization",
 case body.two_factor_requirement_enabled
 when true then 'enabled'
 when false then 'disabled'
 -- if missing, we didn't have permissions to that org
 else 'unknown'
 end as "2FA"
from latestRecord 
JOIN orgsOfInterest ON body.login = orgsOfInterest.Org
order by "2FA" asc, Organization asc