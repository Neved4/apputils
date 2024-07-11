#!/bin/sh
set -Cefu

name='apputil'
script="$name.sh"

has() {
	cmd=${1:?}

	command -v "$cmd" >/dev/null
}

fmt_sh() {
	sed -e '/^#!\/bin\/sh/d' \
		-e '/^set -Cefu/d' \
		-e "/^case \$- in/, \${d;}" "$1" |
			sed '1,/esac/d'
}

fmt_fish() {
	sed -e '/^#!\/usr\/bin\/env fish/d' \
		-e "/^if status is-interactive/, \${d;}"  "$1" |
			sed '1,/end/d' | sed '1,/end/d'
}

case $SHELL in
*zsh)
	profile="$HOME"/.zprofile ;;
*bash)
	profile="$HOME"/.bash_profile ;;
*ksh)
	profile="$HOME"/.profile ;;
*fish)
	script='name.fish' profile="$HOME"/.config/fish/config.fish
	fmt_fish $script > "$profile"
	;;
*)
	echo "Unsupported shell: $SHELL"
	exit 1
	;;
esac

trim "$script" >> "$profile"
