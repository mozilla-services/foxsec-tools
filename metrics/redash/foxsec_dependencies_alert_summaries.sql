SELECT 
concat('<a href="https://github.com/', org, '">', org, '</a>') as org,
concat('<a href="https://github.com/', org, '/', repo, '/network/alerts">', repo, '</a>') as repo,
concat('<a href="https://github.com/', org, '/', repo, '/network/alerts">github alerts page</a>') as github_alerts_page,
concat('<a href="https://sql.telemetry.mozilla.org/dashboard/foxsec-dependencies-alert-details-for-repo?p_org_65119=', org, 
'&p_repo_65119=', repo, '">details</a>') as details,
vulnerabilityAlerts_count as alert_count
FROM `dependency-metadata-236420.dep_observatory.github_meta_repository`
WHERE
 _PARTITIONDATE >= '2019-09-01'
 AND
_PARTITIONDATE IN (
  SELECT
    MAX(_PARTITIONDATE) as pt
  FROM
    `dependency-metadata-236420.dep_observatory.github_meta_repository`
  WHERE _PARTITIONDATE >= '2019-09-01'
)  
ORDER BY alert_count DESC