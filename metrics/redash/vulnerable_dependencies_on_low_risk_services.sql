SELECT meta.service, SUM(repo_join.vulnerabilities) AS vulnerabilities
/* Join 65478 (Services and github org and repo)
   with 65476 (Vulnerability alerts by github org and repo)
   with 65484 (Low risk services)
*/
FROM cached_query_65478 AS meta
INNER JOIN cached_query_65476 repo_join ON meta.repo = repo_join.repo
INNER JOIN cached_query_65484 low_risk ON meta.service = low_risk.service
GROUP BY meta.service
ORDER BY vulnerabilities DESC