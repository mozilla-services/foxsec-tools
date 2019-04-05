-- Query for adhoc examination of repositories not (yet) officially tracked
select Repo, Branch, Protected from foxsec_metrics.all_default_branch_protection_status_latest
where Org like '{{ organization }}'