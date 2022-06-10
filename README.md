# get-acme-wedos

Projekt pro automatizaci instalace/aktualizace acme.sh na servery.

Stáhne:
	* acme.sh - https://github.com/acmesh-official/acme.sh
	* dns_wedos - plugin pro validaci domén přes interní DNS api

Dále vytvoří:
	* /etc/cron.d/acme.sh - cron pro prodlužování certifikátů
	* /etc/logrotate.d/acme.sh - logrotate acme.sh logu /data/letsencrypt/log
	* /data/letsencrypt
	* /data/letsencrypt/acme.sh - acme.sh repo
	* /data/letsencrypt/log - logy
	* /data/letsencrypt/
	* /data/letsencrypt/issue-example.com.sh - vzor skriptu pro počáteční vystavení a instalaci certifikátu

Před vystavením prvního certifikátu je potřeba nastavit autorizaci k DNS API
(je vhodné ponechat na začátku příkazu mezeru, aby se citlivá data neuložila do bash historie)

```
 export WDI_APP_ID=xxx
 export WDI_TOKEN=yyy
```

# install
```
curl https://mrakopes.github.io/get-acme-wedos/  | sh
```

# update
```
curl https://mrakopes.github.io/get-acme-wedos/  | sh -s --update
```
