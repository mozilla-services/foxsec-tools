# A one off script recorded for posterity.
# The Observatory history was held in the file:
# https://github.com/mozilla-services/foxsec-results/blob/master/dashboard/dashboard.json
# This script downloads the right version of the file for each day and copies it
# to a day stamped file. It should be run in the same directory as that file with
# the repo checked out.
# The first version of the file was committed on 2018-05-04 - 146 days before this
# command was run. 

for ((i=146; i>=0; i--))
do
    day=`date -d "-$i days" '+%Y-%m-%d'`
    rev=`git rev-list -n 1 --before="$day 23:59" origin/master`
    git checkout $rev -- dashboard.json
    cp dashboard.json sbsb/$day.json
    echo $day $rev
done
