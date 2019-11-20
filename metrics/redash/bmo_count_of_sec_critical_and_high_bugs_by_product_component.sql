SELECT
  product, component,
  concat('<a href="https://sql.telemetry.mozilla.org/dashboard/bmo-sec-high-critical-bugs-for-product-component?p_product_undefined=', product, '&p_component_undefined=', component, '">link</a>') as link,
  count(*) as count
FROM
  `moz-fx-data-shar-nonprod-efed.eng_workflow_live.bmobugs_v1`
WHERE
  submission_timestamp > '2004-11-09'
  and (bug_status = 'NEW' or bug_status = 'ASSIGNED')
  and ('sec-high' in UNNEST(keywords) or 'sec-critical' in UNNEST(keywords))
GROUP BY product, component  
ORDER BY count desc