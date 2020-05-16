CREATE VIEW foxsec_metrics.heroku_non_staff_latest AS
SELECT *
FROM
  (foxsec_metrics.heroku_non_staff
INNER JOIN (
   SELECT "max"("date") "MaxDay"
   FROM
     heroku_members
)  md ON ("heroku_non_staff"."date" = "MaxDay"))
