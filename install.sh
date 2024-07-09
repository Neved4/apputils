#!/bin/sh
set -Cefu

name='apputil'
script="$name.sh"

has() {
	cmd=${1:?}

	command -v "$cmd" >/dev/null
}

trim() {
	sed -e '/^#!\/bin\/sh/d' \
		-e '/^set -Cefu/d' \
		-e "/^case \$- in/, \${d;}" \
		-e "/^if status is-interactive/, \${d;}" "$1"
}

case $SHELL in
*fish*)
	script="name.fish" ;;
esac

case $SHELL in
*zsh)
	profile="$HOME"/.zprofile ;;
*bash)
	profile="$HOME"/.bash_profile ;;
*ksh)
	profile="$HOME"/.profile ;;
*fish)
	profile="$HOME"/.config/fish/config.fish ;;
*)
	echo "Unsupported shell: $SHELL"
	exit 1
	;;
esac

trim "$script" >> "$profile"
