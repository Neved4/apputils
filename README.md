![Shell Script](https://img.shields.io/badge/Shell_Script-4EAA25?logo=gnubash&logoColor=fff&style=flat)
![macOS](https://img.shields.io/badge/macOS-000000?style=flat&logo=apple&logoColor=fff)
![POSIX.1%2D2017](https://img.shields.io/badge/POSIX.1&#8209;2017-00629B?logo=ieee&logoColor=fff&style=flat)
![Fish Shell](https://img.shields.io/badge/fish%20shell-34C534?logo=fishshell&logoColor=fff&style=flat)

# `apputils` - find macOS app paths!

[`apputils`] is a collection of shell functions to find application bundle
paths.

Available for POSIX shells (e.g. [`bash`], [`ksh`], [`zsh`]) and [`fish`].
Built on `mdfind`.

## Getting Started

> [!NOTE]  
> This utility is meant to only be run on [macOS].

### Prerequisites

Before using [`apputils`], ensure you have:

- A _POSIX compatible shell_, or [`fish`].
- [macOS] with `mdfind` command available.

### Installation

To directly source the scripts and use their functions in your environment:
```sh
$ . /path/to/repo/apputil.sh
$ appdir 'Docker'
```

If you have [`brew`] installed, just run:
```console
$ brew install Neved4/tap/apputils
```

Otherwise, clone the repository or download the script files directly:
```console
$ git clone https://github.com/Neved4/apputils.git
```

Navigate with `cd` into the project directory and then run:
```console
$ ./install.sh
```

## Usage

The following options are available:
```sh
usage: apputil command [options] <app>

Options:
    -i  Perform case-insensitive matching

Commands:
    list  List all installed apps.
    find  List application full path.
    dir   List application parent directory.
```

When added to your shell profile, the following functions are in your
environment:
```sh
applist  List all installed apps.
appfind  List application full path.
appdir   List application parent directory.
```

## Examples

_List all installed application bundles_:
```sh
$ apputil list
```

_Find the path of the application bundle, case-insensitive_:
```sh
$ apputil find -i 'Docker'
```

_Retrieve the directory containing the application bundle_:
```sh
$ apputil dir 'Docker'
```

_Call the former commands as functions in your shell profile_:
```sh
$ applist
/Applications/Safari.app
/System/Applications/Notes.app
/System/Applications/Preview.app

$ appfind -i 'docker'
/Applications/Docker.app

$ appdir 'Docker'
/Applications
```

## Standards

The [apputils.sh](apputils.sh) script is compatible with [ISO
9945:2009][POSIX.1-2017], also known as [POSIX.1-2017].[^1]

## License

[`apputils`] is licensed under the terms of the [MIT License].
   
See the [LICENSE](LICENSE) file for details.

[^3]: _IEEE Std 1003.1-2017: Standard for Information Technology — Portable_
      _Operating System Interface (POSIX®)_, ISO/IEC/IEEE 9945:2009/COR
      2:2017. URL: https://pubs.opengroup.org/onlinepubs/9699919799/

[`apputils`]: https://github.com/Neved4/apputils
[`bash`]: https://www.gnu.org/software/bash/
[`brew`]: https://brew.sh/
[`fish`]: https://fishshell.com/
[`ksh`]: http://kornshell.com/
[`zsh`]: https://www.zsh.org/
[macOS]: https://www.apple.com/macos/
[MIT License]: https://opensource.org/license/mit/
[POSIX.1-2017]: https://pubs.opengroup.org/onlinepubs/9699919799/
