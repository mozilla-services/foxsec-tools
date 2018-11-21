CREATE OR REPLACE VIEW checklist_prod_scores AS 
SELECT service, (sum(case failures when 0 then 1 else 0 end) * 100) / COUNT(DISTINCT item) as score from foxsec_metrics.checklist_item_rollup
where (environment = 'production' or environment = '')
group by (service)
order by (service)
