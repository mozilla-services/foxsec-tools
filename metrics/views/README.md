# Views for working with GitHub data

The GitHub tables are very complex, as the definitions are designed to
cover all the data we collect from different [API][github_api] endpoints

[github_api]: https://developer.github.com/v3/

## General approach

Use tables to load S3 data, often from files produced by the associated
"transformer" for the data source. (Do not generate more than one table
from a raw file.) The SQL for tables should be stored with the data
source's schema directory.

Views may also be used, generally to support Queries (make them easier
to write, or more legible). Since views have a looser connection to
tables, the sql for them is stored in this directory.

**Naming**: the name given a fiew should include a strong hint to the
primary table upon which it is based.

## Specialized 

### GitHub Branch Protection

We collect data for all the branch protections
[recommendations][branch_guidelines]. However, we are slowly rolling out
which permissions we are treating as required. Each recommentation has
it's own calculation. We expect the calculation to change over time, so
it is not handled as a transformation.

We also collect the data for all repository in all orgs, regardless of
their connection to services.  We primarily want to report on only the
repositories that we directly support. The view supporting our subset is
named normally (and generally includes a join on the "\_all" view to
perform the selection). The view supporting all repositories is given a
suffix of "\_all".

[branch_guidelines]: https://github.com/mozilla-services/GitHub-Audit/blob/master/docs/checklist.md

## View Descriptions

### github_default_branch_protection_status_all.sql

This view implements the compliance checking for enabling branch
protection on production branches.

### github_default_branch_protection_status.sql

This view selects the github_default_branch_protection_status_all status
just for the repositories we directly support.

### metadata_repo_parsed.sql

This is a view the repositories we directly monitor, with key components
parsed from the URL string.

# retrieving view descriptions
In order to backup the View creations statements, the following process
is recommended. It is assumed you have CLI creds for the staging
workspace, and have already created a temporary bucket to use for the
query results.

```bash
export AWS_DEFAULT_PROFILE=cloudservices-aws-stage
export AWS_DEFAULT_REGION=us-east-1
DATABASE=foxsec_metrics
S3=s3://hwine-test-stage/athena/output/

# Get a list of all views
stdout=$(aws athena start-query-execution --query-execution-context Database=$DATABASE \
        --result-configuration "OutputLocation=$S3" \
        --query-string "show views" )
qid=$(echo $stdout | jq -r '.QueryExecutionId')

# N.B. all these queries complete "instantly",
#      this is not Athena best practice

# get and display results
aws s3 cp ${S3}${qid}.txt .
cat $qid.txt

# get or update queries
for query in $(cat $qid.txt); do
    stdout=$(aws athena start-query-execution --query-execution-context Database=$DATABASE \
          --result-configuration "OutputLocation=$S3" \
          --query-string "show create view \"$query\"" )
    sqlqid=$(echo $stdout | jq -r '.QueryExecutionId')
    aws s3 cp ${S3}${sqlqid}.txt $query.sql
done
```
