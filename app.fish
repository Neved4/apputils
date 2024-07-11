#!/usr/bin/env fish

function applist
	mdfind "kMDItemContentType == 'com.apple.application-bundle'"
end

function appfind
	applist | grep $argv
end

function appdir
	set path (appfind $argv)

	for i in $path
		set dirname (dirname $i)

		if test -e $i
			echo $dirname
		end
	end
end

if status is-interactive
	exit 0
end

function usage
	set script_name (status basename)

	printf '%s\n' "Usage: $script_name [options] <app>" '' \
		"Commands:" \
		"  list  List all installed apps." \
		"  find  List application full path." \
		"  dir   List application parent directory." '' \
		"Options:" \
		"  -i  Perform case-insensitive matching"
end

function main
	set -l icase
	set -l app_name

	for arg in $argv
		switch $arg
			case "-i"
				set icase '-i'
			case "list"
				set cmd "list"
			case "find"
				set cmd "find"
			case "dir"
				set cmd "dir"
			case '*'
				set app_name $arg
		end
	end

	switch $cmd
		case "list"
			applist
		case "find"
			appfind $icase $app_name
		case "dir"
			appdir $icase $app_name
		case "*"
			printf '%s\n' "Invalid command or no command specified."
			usage
			return 1
	end
end

main $argv
