source $stdenv/setup

header "exporting $url (r$rev) into $out"

if test "$sshSupport"; then
    export SVN_SSH="$openssh/bin/ssh"
fi

if test -n "$http_proxy"; then
    # Configure proxy
    mkdir .subversion
    proxy="${http_proxy#*://}"

    echo '[global]' > .subversion/servers
    echo "http-proxy-host = ${proxy%:*}" >> .subversion/servers
    echo "http-proxy-port = ${proxy##*:}" >> .subversion/servers

    export HOME="$PWD"
fi;

if test -z "$LC_ALL"; then
    export LC_ALL="en_US.UTF-8"
fi;


svnCommand=( svn export --trust-server-cert --non-interactive \
             ${ignoreExternals:+--ignore-externals} ${ignoreKeywords:+--ignore-keywords} )

if test "$privateAuthEnvVarBase"; then
    echo "Using impure environment variables for svn client authentication: "\
         "${privateAuthEnvVarBase}_USERNAME and ${privateAuthEnvVarBase}_PASSWORD"
set -x
    svnfetch_indirect () {
        local var=$1
        echo "${!var}"
    }
    svnCommand+=( --username="$(svnfetch_indirect ${privateAuthEnvVarBase}_USERNAME)"
              --password="$(svnfetch_indirect ${privateAuthEnvVarBase}_PASSWORD)" )
fi
svnCommand+=( -r "$rev" "$url" "$out" )

"${svnCommand[@]}"

stopNest
