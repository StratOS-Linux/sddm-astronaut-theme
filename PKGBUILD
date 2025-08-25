# Maintainer: @zstg <zestig@duck.com>
pkgname=sddm-astronaut-theme
pkgver=1.0+git$(date +%Y%m%d)
pkgrel=1
pkgdesc="SDDM astronaut themes for StratOS – multiple variants included, Qt6‑based with animated wallpapers & virtual keyboard support"
arch=('any')
url="https://github.com/keyitdev/sddm-astronaut-theme"
license=('GPL')
depends=('sddm>=0.21.0' 'qt6-5compat' 'qt6-declarative' 'qt6-svg' 'qt6-virtualkeyboard' 'qt6-multimedia-ffmpeg'
	# 'stratos-fonts'
)
makedepends=('git')
provides=('sddm-astronaut-theme' 'stratos-sddm')
conflicts=('sddm-astronaut-theme')
# source=("git+${url}#tag=master")
# sha256sums=('SKIP')
source=()
install="${pkgname}.install"

pkgver() {
  cd "${srcdir}/" #"${pkgname}"
  printf "1.0+git%s" "$(date +%Y%m%d)"
}

prepare() {
    cp -r $startdir/usr/ $srcdir/usr/
}

package() {
  # cd "${srcdir}/" #"${pkgname}"
  install -dm755 $pkgdir/usr/share/sddm/themes/${pkgname}
  cp -ra $srcdir/usr/share/sddm/themes/${pkgname} $pkgdir/usr/share/sddm/themes/

  # Install fonts
  if [[ -d "Fonts" ]]; then
    install -dm755 $pkgdir/usr/share/fonts/
    cp -a $srcdir/usr/share/sddm/themes/${pkgname}/Fonts/* $pkgdir/usr/share/fonts/
  fi

  # Install metadata.desktop if exists or generate
  install -Dm644 $srcdir/usr/share/sddm/themes/${pkgname}/metadata.desktop $pkgdir/usr/share/sddm/themes/${pkgname}/metadata.desktop
}

# Optional .install script to set theme and virtual keyboard

