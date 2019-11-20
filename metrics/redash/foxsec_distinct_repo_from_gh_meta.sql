SELECT DISTINCT repo
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
ORDER BY repo DESC