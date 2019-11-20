SELECT org, repo, packageManager, COUNT(packagename) as count
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
GROUP BY org, repo, packageManager
ORDER BY count DESC