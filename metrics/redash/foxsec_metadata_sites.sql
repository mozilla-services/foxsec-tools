select status, 
concat ('<a href="https://', url, '">', url, '</a>') as url, 
concat ('<a href="https://', url, path, '">', path, '</a>') as path, 
category, qualifier from foxsec_metrics.metadata_urls
where service = '{{ service }}'

ORDER BY (CASE WHEN status = 'production' THEN 0
	       WHEN status = 'staging' THEN 1
	       WHEN status = 'development' THEN 2
	       WHEN status = 'deprecated' THEN 3
	       ELSE 4 END), url