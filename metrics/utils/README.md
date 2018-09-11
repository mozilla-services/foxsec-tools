# Utilities for the metric project

Utilities in this directory are most likely only needed by the metrics
product.

## gen_athena_ddl - Generate Athena compatible DDL from JSON files

This tool is used to generate DDL from a collection of sample JSON
files.

Athena supports a subset of the HIVE ddl. The [Apache ORC Project][orc]
includes tools which will create HIVE DDL from nested JSON. We don't
need the entire project, just one jar file.  It is only used when adding
a new nested JSON data source, so the jar file is not committed to the
repo.  For installation instructions, run:
```bash
    ./gen_athena_ddl --download
```

The script post processes the orc-tools output to replace types Athena
doesn't support. It also modifies the syntax of the outermost fields to
match what Athena wants.

You'll need to copy/paste the DDL into a 'create table' statement in
Athena. Build the template for that with a single dummy field,
specifying JSON input. (The form does not allow for DDL to be entered.)


[orc]: https://orc.apache.org/
