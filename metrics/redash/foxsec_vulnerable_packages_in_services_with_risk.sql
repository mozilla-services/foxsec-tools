SELECT meta.service,
       meta.org,
       meta.repo,
       meta.risk,
       vuln_pkgs.package_name,
       vuln_pkgs.ecosystem,
       vuln_pkgs.severity,
       vuln_pkgs.vulnerableVersionRange,
       vuln_pkgs.vulnerableManifestPath,
       vuln_pkgs.summary,
       vuln_pkgs.referenceUrls, -- vuln_pkgs.description,
 vuln_pkgs.dismisser_name,
 vuln_pkgs.dismissedAt,
 vuln_pkgs.dismissReason
FROM cached_query_66207 AS vuln_pkgs -- 66207 (vulnerable packages by date, github org and repo) https://sql.telemetry.mozilla.org/queries/66207/source
INNER JOIN cached_query_66214 AS meta ON meta.org = vuln_pkgs.org
AND meta.repo = vuln_pkgs.repo -- 66214 (services w/ org, repo, and risk) https://sql.telemetry.mozilla.org/queries/66214/source
WHERE vuln_pkgs.collection_date >= '{{ dates.start }}'
  AND vuln_pkgs.collection_date <= '{{ dates.end }}'
  AND vuln_pkgs.severity IN ({{ severities }})
  AND meta.risk IN ({{ service_risks }})
  AND meta.org IN ({{ orgs }})
GROUP BY meta.service
ORDER BY meta.risk ASC