CREATE VIEW foxsec_metrics.heroku_service_account AS
SELECT
  "date"
, "email"
, "federated"
, "two_factor_authentication"
, "role"
FROM
  foxsec_metrics.heroku_members
WHERE ((NOT "federated") AND ("email" LIKE '%heroku-%@mozilla.com'))