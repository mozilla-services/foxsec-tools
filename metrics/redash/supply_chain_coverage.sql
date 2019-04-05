WITH tracked_repos AS
  (SELECT foxsec_metrics.pyup.repo_url,
          service
   FROM foxsec_metrics.pyup
   INNER JOIN (foxsec_metrics.metadata_repos) ON (repo_url=repo)
   WHERE date(foxsec_metrics.pyup.day) > (NOW() - INTERVAL '2' DAY))
SELECT CAST(count(distinct(tracked_repos.repo_url)) AS DOUBLE) / CAST(count(distinct(foxsec_metrics.metadata_repos.repo)) AS DOUBLE) * 100 AS "%"
FROM tracked_repos,
     foxsec_metrics.metadata_repos;

