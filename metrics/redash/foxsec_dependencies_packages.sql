SELECT 
concat('<a href="https://sql.telemetry.mozilla.org/dashboard/foxsec-dependencies-repos-with-package?p_package_65009=', 
dep.packagename, '">', dep.packagename, '</a>') as packagename,
       dep.packageManager,
       count(*) as count
FROM `dependency-metadata-236420.dep_observatory.github_meta_repository`
CROSS JOIN UNNEST(dependencies) AS dep
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
GROUP BY packagename, packageManager
ORDER BY packagename, packageManager
