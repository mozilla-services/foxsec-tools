SELECT * FROM foxsec_metrics.aws_route53_diffs, foxsec_metrics.metadata_urls
WHERE aws_route53_diffs.url = metadata_urls.url
AND aws_route53_diffs.action = 'removed'