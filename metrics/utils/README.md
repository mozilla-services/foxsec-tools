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

### Handling illegal field names

Some JSON property names may be illegal. This will be flagged by Athena
during the table creation. The "simplest" way is to prefix each illegal
field name with 'NC_'. (Any yes, that doubles the _ for leading
underscore.)

### Handling "uniontype" schemas

Athena does not understand HIVE's 'uniontype' structure. These are only
generated when the same property has multiple data types (e.g. Array &
Object).

The current workaround is to split the base data into each union type
(see jq in mozilla-services/GitHub-Audit/moz_scripts/ for details).

[orc]: https://orc.apache.org/
