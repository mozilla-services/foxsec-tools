SELECT
_PARTITIONDATE AS collection_date,
org,
repo,
alert.vulnerableManifestPath, 
alert.securityAdvisory.summary,
alert.securityAdvisory.severity,
alert.securityAdvisory.publishedAt,
alert.securityAdvisory.description,
alert.securityAdvisory.referenceUrls,

alert.dismisser.name AS dismisser_name,
alert.dismissedAt,
alert.dismissReason,

vuln.vulnerableVersionRange,
vuln.severity AS vuln_severity, 
vuln.package.name AS package_name, 
vuln.package.ecosystem, 
vuln.firstPatchedVersion, 
vuln.firstPatchedVersion.identifier
FROM `dependency-metadata-236420.dep_observatory.github_meta_repository`
CROSS JOIN UNNEST(vulnerabilityAlerts) AS alert
CROSS JOIN UNNEST(alert.securityAdvisory.vulnerabilities) AS vuln
WHERE
 _PARTITIONDATE >= '2019-09-01'
ORDER BY org, repo, alert.securityAdvisory.severity