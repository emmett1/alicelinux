# Alicelinux
An experimental minimal [musl](https://www.musl-libc.org/) based distro.

alicelinux is not based on any other distro, it follows the **[KISS philosophy](https://en.wikipedia.org/wiki/KISS_principle)**.

## Host Build Dependencies
* rsync
* git
* curl
* base-devel (gcc)
* ccache
## Install dependency needed to build

**Arch linux Install dependency**
```
# pacman -Sy base-devel rsync ccache git curl texinfo
```
**Debian and Ubuntu Install dependency**
```
# apt install build-essential rsync ccache git curl texinfo
```
**Fedora Install dependency**
```
# dnf groupinstall -y "C Development Tools and Libraries"
# dnf groupinstall -y "Development Tools"
# dnf install git rsync curl ccache
```

### How to build Alicelinux
1. git clone **[https://github.com/emmett1/alicelinux.git](https://github.com/emmett1/alicelinux.git)**
2. cd alicelinux
3. Execute ./genconf generate xpkg.conf for build-cross 
4. Execute ./build for build cross-compile

#### Wiki Alicelinux
[wiki is under development](https://github.com/walber-vaz/alicelinux/wiki)

#### LICENSE GPLv3
[LICENSE](https://github.com/emmett1/alicelinux/blob/main/LICENSE)
