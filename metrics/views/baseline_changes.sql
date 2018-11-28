CREATE VIEW foxsec_metrics.baseline_changes AS
SELECT
  "yesterday"."day" "yesterday"
, "today"."day" "today"
, "today"."site"
, "today"."description"
, "yesterday"."status" "old_status"
, "today"."status" "new_status"
FROM
  foxsec_metrics.baseline_details today
, foxsec_metrics.baseline_details yesterday
WHERE ((((((((("today"."day" = "date_format"((current_date - INTERVAL  '1' DAY), '%Y-%m-%d')) AND ("yesterday"."day" = "date_format"((current_date - INTERVAL  '2' DAY), '%Y-%m-%d'))) AND ("today"."rule" = "yesterday"."rule")) AND ("today"."site" = "yesterday"."site")) AND ("today"."status" <> "yesterday"."status")) AND ("today"."status" <> 'ignore_new')) AND ("yesterday"."status" <> 'ignore_new')) AND ("today"."status" <> 'warn_new')) AND ("yesterday"."status" <> 'warn_new'))