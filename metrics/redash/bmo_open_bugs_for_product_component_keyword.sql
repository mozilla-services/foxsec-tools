SELECT
  DISTINCT
  concat('<a href="https://bugzilla.mozilla.org/show_bug.cgi?id=', CAST(bug_id as STRING) , '">', CAST(bug_id as STRING), '</a>') as bug_id, 
  product, component, bug_status --, keywords, flags
FROM
  `moz-fx-data-shar-nonprod-efed.eng_workflow_live.bmobugs_v1`
WHERE
  submission_timestamp > '2004-11-09'
  and (bug_status = 'NEW' or bug_status = 'ASSIGNED')
  and '{{ keyword }}' in UNNEST(keywords)
  and product = '{{ product }}'
  and ('{{ component }}' = '*' OR component = '{{ component }}')
ORDER BY bug_id desc