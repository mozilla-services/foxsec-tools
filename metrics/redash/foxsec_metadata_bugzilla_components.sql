SELECT concat('<a href="https://bugzilla.mozilla.org/buglist.cgi?product=', bz.product, '&component=', bz.component, '">', 
bz.product, ' :: ', bz.component, '</a>') as bugzilla_component
FROM foxsec_metrics.metadata
CROSS JOIN UNNEST(bugzilla) AS t(bz)
where service = '{{ service }}'