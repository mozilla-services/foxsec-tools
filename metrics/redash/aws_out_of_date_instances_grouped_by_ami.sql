SELECT foxsec_metrics.aws_outdated_amis.ami_name,
       count(foxsec_metrics.aws_outdated_amis.ami_name) AS Instances
FROM foxsec_metrics.aws_outdated_amis
JOIN
  (SELECT max(foxsec_metrics.aws_outdated_amis.day) AS MaxDay
   FROM foxsec_metrics.aws_outdated_amis) md ON foxsec_metrics.aws_outdated_amis.day = MaxDay
WHERE foxsec_metrics.aws_outdated_amis.status = 'fail'
GROUP BY foxsec_metrics.aws_outdated_amis.ami_name