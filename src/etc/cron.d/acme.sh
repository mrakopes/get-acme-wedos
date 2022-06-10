# acme.sh renew

0 0 * * * root sleep $((RANDOM\%7200)); /data/letsencrypt/acme.sh/acme.sh --home /data/letsencrypt/workdir --cron --dnssleep 600 --log /data/letsencrypt/log/acme.sh.log > /dev/null
