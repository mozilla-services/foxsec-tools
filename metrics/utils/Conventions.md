# Conventions for the Metrics Project

Here are a few of the conventionbs we loosely follow.

## Data File Formats

Various formats are supported, and have been used. Based on experience "flat JSON" is the easiest to work with.

For all formats, Athena requires one record per line, and no header record.
- CSV/TSV: okay, but puts burden of keeping the column names straight on the users
- JSON (nested): The DDL for nested JSON is hard to construct. 
There are some [tools](README.md) in this directory which assist, but it can be a trial and error process.

## Data File Names

By convention, all data file names should begin with the UTC collection date, formatted as `YYYY-MM-DD`. 
The rest of the file name is up to the provider, but no spaces should be used.

The file extension should be appropriate for the internal representation.

## Standard Fields

It is highly recommended that each record contains the UTC data collection date, as the field `day`, formatted in iso style. 
(I.e. the output of `date --utc --iso`.) While the date is available in the file name, 
the Athena processing does not allow that to be referenced.

If you're using a nested JSON format, the `day` field should be on the top level. (I.e. not nested.)

## S3 layout

```code
<bucket>
└── <service>
    ├── <schema_1>
    ├── <schema_2>
    └── raw
```
Underneath `<service>`, it's important that all files within a `<schema_*>` directory have files that all conform to the same schema. This is the directory level at which the Athena import will occur, and Athena only supports one schema per directory.

A copy of the "raw" data downloaded from the service should be placed into `/raw/`. The original thought is this would allow reprocessing of data if the schema evolved, but that has not yet occurred.

