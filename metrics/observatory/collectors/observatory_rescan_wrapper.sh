# Wrapper for running the observatory rescan script

# Clone repo
git clone https://$cloudsecBotPat@github.com/mozilla-services/foxsec.git

python3 collectors/observatory_rescan.py -m foxsec/services/metadata
 
