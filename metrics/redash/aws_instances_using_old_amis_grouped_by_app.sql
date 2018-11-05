SELECT aws_outdated_amis.instance_app,
       aws_outdated_amis.status,
       count(*) AS COUNT
FROM "foxsec_metrics"."aws_outdated_amis"
JOIN
  ( SELECT max(aws_outdated_amis.day) AS MaxDay
   FROM aws_outdated_amis) md ON aws_outdated_amis.day = MaxDay
WHERE aws_outdated_amis.status = 'fail'
GROUP BY foxsec_metrics.aws_outdated_amis.instance_app,
         foxsec_metrics.aws_outdated_amis.status
ORDER BY COUNT