SELECT service,
       servicekey,
       split_part(url_extract_path(coderepository.url), '/', 2) as org,
       replace(split_part(url_extract_path(coderepository.url), '/', 3), '.git') as repo,
       coderepository.url as repo_url,
       coderepository.status
FROM foxsec_metrics.metadata
CROSS JOIN UNNEST(coderepositories) AS t(coderepository)
ORDER BY service,
         coderepository.url DESC