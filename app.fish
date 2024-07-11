#!/usr/bin/env fish

function applist
	mdfind "kMDItemContentType == 'com.apple.application-bundle'"
end

function appfind
	set -l icase
	set -l app_name

	if test "$argv[1]" = "-i"
		set icase '-i'
		set -e argv[1]
	end

	set app_name $argv[1]

	if not string match -qr '\.app$' -- $app_name
		set app_name "$app_name.app"
	end

	for item in (applist)
		if string match -q $icase -- "*$app_name*" $item
			printf '%s\n' $item
		end
	end
end

function appdir
	set -l icase
	set -l app_name
	set -l path

	if test "$argv[1]" = "-i"
		set icase '-i'
		set -e argv[1]
	end

	set app_name $argv[1]
	set path (appfind $icase $app_name)

	if test -n "$path"
		printf '%s\n' (dirname $path)
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
