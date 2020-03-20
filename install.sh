#!/bin/sh
# Heavily adapted from the pivpn.io
#
# curl -L http://spelling.alegret.tech | bash
# Make sure you have `curl` installed

######## SCRIPT ########

main() {
	######## FIRST CHECK ########
	# Must be root to install
	if [[ ! $EUID -eq 0 ]]; then
		export SUDO="sudo"
	fi
    selectLanguage
}

downloadLanguage() {
    if [[ ! -d "/Library/Spelling/" ]]; then
    	$SUDO mkdir -p /Library/Spelling/
    fi
    cd "/Library/Spelling/"
    $SUDO curl -f https://raw.githubusercontent.com/rnicolas/spelling/master/language/"$1"/hyph_"$1".dic -O
    if [[ -n "$2" ]]; then
        $SUDO curl -L https://raw.githubusercontent.com/rnicolas/spelling/master/language/"$1"/"$2".dic -O
        $SUDO curl -L https://raw.githubusercontent.com/rnicolas/spelling/master/language/"$1"/"$2".aff -O
    else
        $SUDO curl -L https://raw.githubusercontent.com/rnicolas/spelling/master/language/"$1"/"$1".dic -O
        $SUDO curl -L https://raw.githubusercontent.com/rnicolas/spelling/master/language/"$1"/"$1".aff -O
    fi
}

selectLanguage() {
    echo "Which language do you want to install?" 
    read language < /dev/tty
    case $language in
        "ca" | "cat" | "catala" | "català" | "catalan")
            downloadLanguage "ca"
            ;;
        "va" | "val" | "valencia" | "valencià" | "valencian")
            downloadLanguage "ca" "ca-valencia"
            ;;
        "oc" | "occitan" | "occità")
            downloadLanguage "oc"
            ;;
        *)
            echo "language not found"
            ;;
    esac

}

main $@