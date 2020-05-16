# Backups of re:Dash objects for SecOps Metrics (Athena) data source

## How to backup "all" queries

The backup process needs the query ids, but there is no reasonable API to
retrieve them programmatically. We work around this by saving the results of a
manual query to files, which are then processed by `backup_queries`.

The recommended steps are:
1. ensure your repo is up to date
1. Form the desired query on
   [STMO](https://sql.telemetry.mozilla.org/queries?page=1&page_size=200) --
   usually, we use the tag 'secops'.

   - Note that the above link is pre-configured for the maximum results per
     page. If you don't use this link, go to the bottom of the [query
     page](https://sql.telemetry.mozilla.org/queries) to change the number.
1. Save the page locally using the "File" -> "Save Page As..." menu option, and
   selecting the "Text Files" format.
1. Repeat for each page of the query results, giving a unique name to each
   output file.
1. Run the script in this directory, passing all the output files as arguements:
    ```bash
    ./backup_queries Query*.txt
    ```
1. Add all the new and modified files to git, and commit:
    ```bash
    git add .
    git commit -am "Backup on $(date --iso)"
    git push
    ```

## Tooling and Prerequisites

The recommended way to maintain these files is via the
[stmocli][stmocli] tool. The instructions here assume you have that
installed.

The instructions also assume you have put your user api key into the
environment variable REDASH_API_KEY. Since the API key cannot be reset,
please be careful with those! Sample bash script (assumes your API key is kept
in password-store):
```bash
#!/usr/bin/env bash
# wrap stmocli to put API key in environment, and call the real one

export REDASH_API_KEY=$(pass Mozilla/stmo-redash-api)

exec stmocli "$@"
```

### Using stmocli

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

#### Notes & Tips

- ``stmocli`` downloads the query scheduling information, but push does
  not change scheduling. If you're restoring a lost query, or have
  forked one that is scheduled, you'll need to set the scheduling via
  the web UI.

<!-- References used above -->
[stmocli]: https://github.com/mozilla/stmocli
