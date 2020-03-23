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
    echo "To proceed, the script needs to go sudo, so it will ask for your password. If you are not agree with that, just kill the script."
    echo ""
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
    read -p "Which language do you want to install? " language < /dev/tty
    case $language in
        "ca" | "cat" | "catala" | "català" | "catalan")
            downloadLanguage "ca"
            ;;
        "ca-valencia" | "va" | "val" | "valencia" | "valencià" | "valencian")
            downloadLanguage "ca" "ca-valencia"
            ;;
        "oc" | "occitan" | "occità")
            downloadLanguage "oc"
            ;;
        "gl" | "galego" | "gallego" | "galician")
            downloadLanguage "gl"
            ;;
        "ro" | "română" | "romana" | "romanian" | "rumanian" | "roumanian")
            downloadLanguage "ro"
            ;;
        "is" | "icelandic" | "islenska" | "íslenska")
            downloadLanguage "is"
            ;;
        "id" | "indonesian" | "bahasa Indonesia" | "bahasa indonesia")
            downloadLanguage "id"
            ;;
        "bg" | "bulgarian" | "български")
            downloadLanguage "bg"
            ;;
        *)
            echo "language not found"
            ;;
    esac
}

main $@