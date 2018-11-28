CREATE VIEW foxsec_metrics.heroku_member_transitioning AS
SELECT
  "date"
, "email"
, "federated"
, "two_factor_authentication"
, "role"
FROM
  foxsec_metrics.heroku_members
WHERE ((NOT "federated") AND ("role" IN ('admin', 'member')))