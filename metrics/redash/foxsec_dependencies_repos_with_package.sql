SELECT 
concat('<a href="https://github.com/', org, '">', org, '</a>') as org,
concat('<a href="https://github.com/', org, '/', repo, '">', repo, '</a>') as repo,
       dep.packageManager,
       dep.packagename,
       dep.requirements,
concat('<a href="https://github.com/', org, '/', repo, '/tree/master/', dep.manifest_filename, '">', dep.manifest_filename, '</a>') as manifest_filename

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
AND dep.packagename = '{{ package }}'
ORDER BY org,
         repo DESC