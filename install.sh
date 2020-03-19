#!/bin/sh
# Heavily adapted from the pivpn.io
#
# curl -L http://www.alegret.tech/spelling | bash
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
    selectLanguage
}

downloadLanguage() {
    if [[! -d "/Library/Spelling/" ]]; then
    	$SUDO mkdir -p /Library/Spelling/
    fi
    mv /Library/Spelling/
    curl -L https://raw.githubusercontent.com/rnicolas/spelling/master/ + $1 + / + $1 + .dic
    curl -L https://raw.githubusercontent.com/rnicolas/spelling/master/ + $1 + / + $1 + .aff
    if [[$2]]; then
        curl -L https://raw.githubusercontent.com/rnicolas/spelling/master/ + $1 + /hyph_ + $2 + .dic
    else
        curl -L https://raw.githubusercontent.com/rnicolas/spelling/master/ + $1 + /hyph_ + $1 + .dic
    fi
}

selectLanguage() {
    echo "::: Which language do you want to install?"
    read language
    case "$language" in
    "ca" | "cat" | "catala" | "català" | "catalan")
        downloadLanguage "ca"
        ;;
    "va" | "val" | "valencia" | "valencià" | "valencian")
        downloadLanguage "ca-valencia" "ca"
        ;;
    "oc" | "occitan" | "occità")
        downloadLanguage "oc"
    *)
        echo "language not found"
        ;;
    esac

}

main