#!/usr/bin/env sh


cmd_exists() {
	cmd="$1"
	if [ -z "$cmd" ] ; then
		echo "Usage: _exists cmd"
		return 1
	fi
	if type command >/dev/null 2>&1 ; then
		command -v $cmd >/dev/null 2>&1
	else
		type $cmd >/dev/null 2>&1
	fi
	ret="$?"
	return $ret
}

preflight_checks() {
	if ! cmd_exists git; then
		echo "git command not found"
		echo "Please install it and try again."
		return 1
	fi
	return 0
}

preinstall_checks() {
	res=0

	if [ -f /etc/cron.d/acme.sh ]; then
		echo "file /etc/cron.d/acme.sh already exists"
		res=1
	fi
	if [ -f /etc/logrotate.d/acme.sh ]; then
		echo "file /etc/logrotate.d/acme.sh already exists"
		res=1
	fi
	if [ -d /data/letsencrypt ]; then
		echo "dir /data/letsencrypt already exists"
		res=1
	fi

	if [ $res -eq 1 ]; then
		echo "files/dirs mentioned above already exists, remove them to cotinue"
		echo "or maybe you want to run an update (--update)?"
		return 1
	fi
	return 0
}



ACTION=install

# parse parameters
while [ $# -gt 0 ]; do
	case "$1" in
		-i|--install)
			ACTION=install
			shift
			;;
		-u|--update)
			ACTION=update
			shift
			;;
		*)
			echo "unknown parameter $1"
			exit 1
			;;
	esac
done

preflight_checks || exit 1

case $ACTION in
	install)
		run_install
		;;
	update)
		run_update
		;;
	*)
		echo "unknown action '$ACTION'"
		exit 1
		;;
esac

