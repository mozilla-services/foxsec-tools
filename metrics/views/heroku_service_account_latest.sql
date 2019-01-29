CREATE VIEW foxsec_metrics.heroku_service_account_latest AS
SELECT *
FROM
  (foxsec_metrics.heroku_service_account
INNER JOIN (
   SELECT "max"("date") "MaxDay"
   FROM
     heroku_members
)  md ON ("heroku_service_account"."date" = "MaxDay"))