-- list archive <-> active repositories
with
repos_of_interest as
(
select distinct org, repo, status
from foxsec_metrics.github_branches_of_interest
),
latest_repos as
(
select body.archived, url
from foxsec_metrics.github_object_latest
where body.archived is not null
)
select status, archived, org, repo, url
from repos_of_interest as a
left outer join latest_repos as b
on b.url = concat('/repos/', org, '/', repo)
-- limit 10
