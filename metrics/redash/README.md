# Backups of re:Dash objects for SecOps Metrics (Athena) data source

## Tooling and Prerequisites

The recommended way to maintain these files is via the
[stmocli][stmocli] tool. The instructions here assume you have that
installed.

The instructions also assume you have put your user api key into the
environment variable REDASH_API_KEY. Since the API key cannot be reset,
please be careful with those! Sample bash script:
```bash
#!/usr/bin/env bash
# wrap stmocli to put API key in environment, and call the real one

export REDASH_API_KEY=$(pass Mozilla/stmo-redash-api)

exec stmocli "$@"
```

## Using stmocli

We only use two commands in normal use. The query ID can be found in any
URL after you save the query.

To pull down the latest version of the query (including the initial
one):
```bash
stmocli-wrapper track  QUERY_ID
```

To deploy your changes (overwrites):
```bash
stmocli-wrapper push  LOCAL_FILE_NAME
```

## Notes & Tips

- ``stmocli`` downloads the query scheduling information, but push does
  not change scheduling. If you're restoring a lost query, or have
  forked one that is scheduled, you'll need to set the scheduling via
  the web UI.

<!-- References used above -->
[stmocli]: https://github.com/mozilla/stmocli
