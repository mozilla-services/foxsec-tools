CREATE OR REPLACE VIEW checklist_item_rollup AS 
SELECT service, environment, section, item, sum (case pass when 'false' then 1 else 0 end) failures from foxsec_metrics.checklist
group by (service, environment, section, item)
order by (service, environment, section)
