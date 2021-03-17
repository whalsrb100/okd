#!/bin/bash
cat /var/www/html/okd/menifests/cluster-sche* | grep masterSchedulable
sed -i 's/  mastersSchedulable: true/  mastersSchedulable: false/' /var/www/html/okd/menifests/cluster-sche*
cat /var/www/html/okd/menifests/cluster-sche* | grep masterSchedulable
