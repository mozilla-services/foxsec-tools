SELECT * FROM foxsec_metrics.aws_route53_diffs
WHERE url NOT IN (select url FROM metadata_urls)
AND action = 'added'
ORDER BY day desc