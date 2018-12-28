CREATE VIEW foxsec_metrics.heroku_invalid_staff_sso AS
SELECT *
FROM
  foxsec_metrics.heroku_members
WHERE (((NOT "federated") AND ("email" LIKE '%@mozilla.com')) AND (NOT ("email" LIKE 'heroku-%@mozilla.com')))