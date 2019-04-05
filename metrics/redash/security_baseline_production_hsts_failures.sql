SELECT 
	foxsec_metrics.baseline_details.day,
	foxsec_metrics.metadata_urls.service,
	site,
	concat('<a href="https://sql.telemetry.mozilla.org/dashboard/security-baseline-site-scores?p_day_60202=', day, '&p_site_60202=' , site, '">', site, '</a>') as sitelink,
	case
	    when length(progresslink) > 0 then concat('<a href="', progresslink, '">link</a>')
	    else ''
	end link,
	foxsec_metrics.baseline_details.failingurls
FROM foxsec_metrics.baseline_details
INNER JOIN foxsec_metrics.metadata_urls ON foxsec_metrics.metadata_urls.url = foxsec_metrics.baseline_details.site
join (
    select max(baseline_details.day) as MaxDay
    from baseline_details
) md on baseline_details.day = MaxDay
WHERE foxsec_metrics.metadata_urls.status = 'production'
  AND foxsec_metrics.metadata_urls.category != 'Static'
  AND foxsec_metrics.baseline_details.rule = 'rule_10035'
  AND (
        foxsec_metrics.baseline_details.status = 'fail' OR
        foxsec_metrics.baseline_details.status = 'fail_in_progress' OR
        foxsec_metrics.baseline_details.status = 'fail_new'
)
ORDER BY foxsec_metrics.metadata_urls.service, foxsec_metrics.baseline_details.site ASC;
