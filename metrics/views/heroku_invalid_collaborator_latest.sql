CREATE VIEW foxsec_metrics.heroku_invalid_collaborator_latest AS
SELECT *
FROM
  (foxsec_metrics.heroku_invalid_collaborator
INNER JOIN (
   SELECT "max"("date") "MaxDay"
   FROM
     heroku_members
)  md ON ("heroku_invalid_collaborator"."date" = "MaxDay"))