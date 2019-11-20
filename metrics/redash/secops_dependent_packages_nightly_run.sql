SELECT org,
       repo,
       dep.packageManager,
       dep.packagename,
       dep.requirements,
       dep.manifest_filename
FROM `dependency-metadata-236420.dep_observatory.github_meta_repository`
CROSS JOIN UNNEST(dependencies) AS dep
WHERE _PARTITIONDATE = CURRENT_DATE()
ORDER BY org,
         repo DESC