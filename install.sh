#!/usr/bin/env bash
# Heavily adapted from the pivpn.io
#
# curl -L https://rnicolas.github.com/spelling | bash
# Make sure you have `curl` installed

######## SCRIPT ########

main() {
	######## FIRST CHECK ########
	# Must be root to install
	echo ":::"
	if [[ $EUID -eq 0 ]]; then
		echo "::: You are root."
	else
		echo "::: You need to run this command as root"
	fi

    if [[! -d "/Library/Spelling/" ]]; then
    	$SUDO mkdir -p /Library/Spelling/
    fi
}

main "$@"