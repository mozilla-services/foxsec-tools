# Clone repo
git clone https://$cloudsecBotPat@github.com/mozilla-services/foxsec.git

# Run the deprecated sites check
python3 check/depricated_sites.py -m foxsec/services/metadata > depeciated_output 2>&1

if [ -s 'depeciated_output' ]; then
   # Some of the tests have failed, raise an alert
   ../../utils/raise_github_issue.py -t "Deprecated or terminated sites changed" -f depeciated_output -a psiinon -r foxsec-results -p $cloudsecBotPat
fi
