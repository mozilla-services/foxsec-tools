CREATE VIEW foxsec_metrics.heroku_service_account AS
SELECT *
FROM
  foxsec_metrics.heroku_members
WHERE ((NOT "federated") AND ("email" LIKE '%heroku-%@mozilla.com'))