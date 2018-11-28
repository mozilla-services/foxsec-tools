CREATE VIEW foxsec_metrics.heroku_member_no_2fa AS
SELECT
  "date"
, "email"
, "federated"
, "two_factor_authentication"
, "role"
FROM
  foxsec_metrics.heroku_members
WHERE ((NOT "federated") AND (NOT "two_factor_authentication"))