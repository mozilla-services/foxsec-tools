CREATE VIEW foxsec_metrics.heroku_invalid_collaborator AS
SELECT *
FROM
  foxsec_metrics.heroku_members
WHERE ((NOT "federated") AND (NOT "two_factor_authentication"))