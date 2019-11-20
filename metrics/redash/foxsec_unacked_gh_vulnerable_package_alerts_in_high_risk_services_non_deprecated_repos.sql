SELECT collection_date,
       meta.service,
       meta.org,
       meta.repo,
       count(1) AS unacked_alerts
FROM cached_query_66207 AS vuln_pkgs -- 66207 (vulnerable packages by date, github org and repo) https://sql.telemetry.mozilla.org/queries/66207/source

INNER JOIN cached_query_66214 AS meta 
ON meta.org = vuln_pkgs.org AND meta.repo = vuln_pkgs.repo -- 66214 (services w/ org, repo, and risk) https://sql.telemetry.mozilla.org/queries/66214/source

INNER JOIN query_66351 AS repo_statuses -- 66351 (svc repos w/ url and status) https://sql.telemetry.mozilla.org/queries/66351/source
ON meta.org = repo_statuses.org AND meta.repo = repo_statuses.repo -- repo_statuses has different service fields so don't join on them

WHERE vuln_pkgs.collection_date >= MAX('{{ dates.start }}', '2019-09-01') 
  AND vuln_pkgs.collection_date <= '{{ dates.end }}' 
  AND meta.risk IN ({{ service_risks }}) 
  AND vuln_pkgs.dismissedAt IS NULL
  AND repo_statuses.status != 'deprecated'
GROUP BY collection_date,
         meta.service,
         meta.org,
         meta.repo
ORDER BY collection_date DESC