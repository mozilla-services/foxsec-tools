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