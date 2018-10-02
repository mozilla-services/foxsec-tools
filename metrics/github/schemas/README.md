Because Athena does not support 'uniontype', any JSON which requires
them needs to be split into multiple schemas: one for each type of the
union.

Currently, the GitHub output has only one union type, at the top level
of JSON returned from calls. Most calls return an object, a few return
an array. Hence the 2 files: github_object.sql & github_array.sql

Note on viewing these files. The GitHub data is very nested - do not try
to form your query by examining the schema. Rather, view the GitHub API
docs for the data you want, and access fields based on the JSON response
for that particular call.

# Regenerating the schema

If additional API calls are added to the collection, the schema may need
to be regenerated.

For GitHub, that is a two step process:
- generate the DDL
- incorporate the DDL into the Athena sql

In some cases, this may be an iterative approach.

If you're lucky, your new data only has to deal with one option of the
existing "uniontype" (on "body").

## Create the DDL

1. Determine which union type you're working with (array or object)
2. get one or more JSON files into a directory which includes examples
   of all currently collected data, of the correct union type.

   In practice, you just want to ensure the data includes the new JSON
   structures, and add that into a pile of historical data downloaded
   from S3.
3. Use the [gen_athena_ddl][gen_athena_ddl] script to generate DDL.

[gen_athena_ddl]: https://github.com/mozilla-services/foxsec-tools/tree/master/metrics/utils

## Combine with Athena SQL

1. Use the prior schema as a base, but:
    - change the output table name
    - replace the DDL with the new values
2. Paste the resulting SQL into an Athena query, and execute it.

   If it works, verify you can access the new data types. If that also
   works, skip to the [next step](#clean-up)
3. If it doesn't work, figure out why not. Some prior causes:
    - incorrect quoting in DDL
    - illegal field name
    - unsupported DDL element

   All of these require modifications to
   [gen_athena_ddl][gen_athena_ddl]. Be sure to document and commit
   those changes.
4. Try again


## Finalize the change

<a id="clean-up" />

1. Commit new SQL with correct table name.
2. Delete any test tables in Athena.
3. Do the swap - time sensative, as there is interim breakage
    1. Delete the oly production table
    2. Use the committed SQL to generate the new production table
4. Push everything.
