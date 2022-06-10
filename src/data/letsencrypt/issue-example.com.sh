#!/bin/bash

/data/letsencrypt/acme.sh/acme.sh \
	--home /data/letsencrypt/workdir/ \
	--dns dns_wedos_int \
	--insecure \
	--issue \
	--log /data/letsencrypt/log/acme.sh.log \
	--server  letsencrypt \
	-d *.example.com \
	|| exit 1


# issue *.m*.wedos.net
/data/letsencrypt/acme.sh/acme.sh \
	--home /data/letsencrypt/workdir/ \
	--dns dns_wedos_int \
	--insecure \
	--issue \
	--log /data/letsencrypt/log/acme.sh.log \
	--server  letsencrypt \
	`echo "-d *.x"{0..99}".example.com"` \
	|| exit 1

# install
/data/letsencrypt/acme.sh/acme.sh \
	--home /data/letsencrypt/workdir/ \
	--install-cert \
	--log /data/letsencrypt/log/acme.sh.log \
	--key-file /data/test/certs/star.example.com.key \
	--fullchain-file /data/test/certs/star.example.com.crt \
	--reloadcmd "systemctl reload httpd" \
	-d *.example.com \
	|| exit 1

/data/letsencrypt/acme.sh/acme.sh \
	--home /data/letsencrypt/workdir/ \
	--install-cert \
	--log /data/letsencrypt/log/acme.sh.log \
	--reloadcmd \
		"cat \$CERT_KEY_PATH \$CERT_FULLCHAIN_PATH > /data/test/certs/star.example.com-stnd.pem && \
		systemctl reload haproxy" \
	-d *.m0.wedos.net \
	|| exit 1

echo "done"
exit 0
