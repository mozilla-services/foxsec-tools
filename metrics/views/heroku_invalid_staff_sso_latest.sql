CREATE VIEW foxsec_metrics.heroku_invalid_staff_sso_latest AS
SELECT *
FROM
  (foxsec_metrics.heroku_invalid_staff_sso
INNER JOIN (
   SELECT "max"("date") "MaxDay"
   FROM
     heroku_members
)  md ON ("heroku_invalid_staff_sso"."date" = "MaxDay"))