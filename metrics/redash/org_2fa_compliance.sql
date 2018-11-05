SELECT distinct body.login AS "Org",
              body.two_factor_requirement_enabled AS "2FA"
FROM foxsec_metrics.github_object
WHERE (body.two_factor_requirement_enabled IS NOT NULL)
ORDER BY "2FA",
         "Org";