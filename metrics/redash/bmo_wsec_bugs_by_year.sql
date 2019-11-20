SELECT
  concat('<a href="https://sql.telemetry.mozilla.org/dashboard/bmo-open-bugs-for-keyword?p_keyword_undefined=%27', keyword, '%27">', keyword, '</a>') as keyword, 
  count(distinct bug_id) as count,
  FORMAT_DATE("%Y", DATE(TIMESTAMP(creation_ts))) as year
FROM
  `moz-fx-data-shar-nonprod-efed.eng_workflow_live.bmobugs_v1`
CROSS JOIN UNNEST(`moz-fx-data-shar-nonprod-efed.eng_workflow_live.bmobugs_v1`.keywords) AS keyword
WHERE
  submission_timestamp > '2009-05-28'
  and STARTS_WITH(keyword, 'wsec-')
  and EXTRACT(YEAR FROM DATE(TIMESTAMP(creation_ts))) >2010
GROUP BY year,keyword
ORDER BY year,keyword DESC