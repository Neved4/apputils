#!/bin/sh
set -Cefu

applist() {
	mdfind "kMDItemContentType == 'com.apple.application-bundle'"
}

appfind() {
	applist | GREP_OPTIONS='' grep "$@"
}

appdir() {
	path=$(appfind "$@")

	for i in $path
	do
		dirname=${i%/*}

		[ -e "$i" ] && printf '%s\n' "$dirname"
	done
}

case $- in
*i*)
	set +Cefu && return 0
esac

usage() {
	progname=${0##*/}

	printf '%s\n' "Usage: $progname command [options] <app>" '' \
    	"Commands:" \
    	"  list   List all installed apps." \
    	"  find   List application full path." \
    	"  dir    List application parent directory." '' \
		"Options:" \
    	"  -i  Perform case-insensitive matching"
} >&2

cmdparse() {
    cmd=$1

    case $cmd in
    list|find|dir)
        shift 1 ;;
    *)
        printf '%s\n' "Invalid command: $cmd"
        usage
        exit 1
    esac
}

optparse() {
	iflag=

	while getopts i name
	do
		case $name in
		i)
			iflag='-i' ;;
		?)
			usage
			exit 1
			;;
		esac
	done
}

main() {
	cmdparse "$1" && shift 1
	optparse "$@" && shift $((OPTIND - 1))

	case $cmd in
	list) applist $iflag "$@" ;;
	find) appfind $iflag "$@" ;;
	 dir) appdir  $iflag "$@" ;;
	esac
}

main "$@"
