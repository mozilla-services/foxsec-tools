-- fork from Heroku Problem Accounts
-- which should be pushed back to Athena
-- Report on all non-compliant Heroku users
-- Value should always be 0
with invalid_accounts as
(
SELECT email,
       role,
       federated,
       two_factor_authentication
FROM heroku_invalid_collaborator_latest
UNION ALL
SELECT email,
       role,
       federated,
       two_factor_authentication
FROM heroku_invalid_staff_sso_latest
)
select count(*) from invalid_accounts