# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2020-present AmberELEC (https://github.com/AmberELEC)

PKG_NAME="hatari"
PKG_VERSION="1ebf0a0488580ef95c0b28f02223b31813c867c5"
PKG_SHA256="520b3666a8cf795a89f8bf322dc77749cf8b1994a1f613f098cd6d4ed5382011"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/hatari"
PKG_URL="${PKG_SITE}/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain capsimg"
PKG_LONGDESC="New rebasing of Hatari based on Mercurial upstream. Tries to be a shallow fork for easy upstreaming later on."
PKG_TOOLCHAIN="make"

configure_target() {
  :
}

make_target() {
  if [ "${ARCH}" == "arm" ]; then
    CFLAGS="${CFLAGS} -DNO_ASM -DARM -D__arm__ -DARM_ASM -DNOSSE -DARM_HARDFP"
  fi
  CFLAGS="${CFLAGS} -I$(get_build_dir capsimg)/Core -I$(get_build_dir capsimg)/.install_pkg/usr/local/include -L$(get_build_dir capsimg)/.install_pkg/usr/lib -lcapsimage -DHAVE_CAPSIMAGE=1 -DCAPSIMAGE_VERSION=5"
  LDFLAGS="${LDFLAGS} -I$(get_build_dir capsimg)/LibIPF -DHAVE_CAPSIMAGE=1"
  make -C .. -f Makefile.libretro
}

makeinstall_target() {
  mkdir -p ${INSTALL}/usr/lib/libretro
  mkdir -p ${INSTALL}/usr/config/distribution/configs/hatari
  cp ../hatari_libretro.so ${INSTALL}/usr/lib/libretro/
  cp -rf ${PKG_DIR}/config/* ${INSTALL}/usr/config/distribution/configs/hatari/
}
