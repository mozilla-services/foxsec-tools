SELECT repos.status, repos.hostingservice, repos.vcs, 
concat('<a href="', repos.url, '">', repos.url, '</a>') as url, 
repos.comment
FROM foxsec_metrics.metadata
CROSS JOIN UNNEST(coderepositories) AS t(repos)
where service = '{{ service }}'
ORDER BY repos.status, repos.hostingservice, repos.url