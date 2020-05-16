CREATE VIEW foxsec_metrics.heroku_non_staff AS
SELECT *
FROM
  foxsec_metrics.heroku_members
WHERE ((NOT "federated") AND (NOT ("email" LIKE '%@mozilla.com')))
