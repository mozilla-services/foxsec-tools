SELECT meta.service, dep_join.packageManager, SUM(dep_join.count) AS dependency_count
/* Join 65478 (Services and github org and repo)
   with 65482 (Dependencies per repo and package manager)
   with 65480 (High risk services)
*/
FROM query_65478 AS meta
INNER JOIN query_65482 dep_join ON meta.repo = dep_join.repo
GROUP BY meta.service, dep_join.packageManager
ORDER BY dependency_count DESC