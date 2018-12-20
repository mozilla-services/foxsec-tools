select concat('<a href="https://sql.telemetry.mozilla.org/dashboard/foxsec-checklist-per-service?p_service_59948=', service, 
'&p_service_59949=', service, '&p_service_59952=', service, '&p_service_59953=', service,
'">', service, '</a>') as service, score,
case
when score >= 80 then concat('<div class="bg-success p-10 text-center">', CAST(score AS VARCHAR), '</div>')
when score >= 50 then concat('<div class="bg-warning p-10 text-center">', CAST(score AS VARCHAR), '</div>')
ELSE concat('<div class="bg-danger p-10 text-center">', CAST(score AS VARCHAR), '</div>')
END AS percent
from foxsec_metrics.checklist_prod_scores