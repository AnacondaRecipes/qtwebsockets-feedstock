#!/bin/sh

set -ex

export LD_LIBRARY_PATH="${BUILD_PREFIX}/${HOST}/sysroot/usr/lib64:${BUILD_PREFIX}/${HOST}/sysroot/usr/lib:${LD_LIBRARY_PATH}"

cmake -S"${SRC_DIR}/${PKG_NAME}" -Bbuild -GNinja ${CMAKE_ARGS} \
  -DCMAKE_PREFIX_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_RPATH=${PREFIX}/lib \
  -DCMAKE_BUILD_WITH_INSTALL_RPATH=ON \
  -DCMAKE_FIND_FRAMEWORK=LAST \
  -DBUILD_WITH_PCH=OFF \
  -DINSTALL_BINDIR=lib/qt6/bin \
  -DINSTALL_PUBLICBINDIR=bin \
  -DINSTALL_LIBEXECDIR=lib/qt6 \
  -DINSTALL_DOCDIR=share/doc/qt6 \
  -DINSTALL_ARCHDATADIR=lib/qt6 \
  -DINSTALL_DATADIR=share/qt6 \
  -DINSTALL_INCLUDEDIR=include/qt6 \
  -DINSTALL_MKSPECSDIR=lib/qt6/mkspecs \
  -DINSTALL_EXAMPLESDIR=share/doc/qt6/examples
cmake --build build --target install

pushd "${PREFIX}"

mkdir -p bin

if [[ -f "${SRC_DIR}"/build/user_facing_tool_links.txt ]]; then
  for links in "${SRC_DIR}"/build/user_facing_tool_links.txt; do
    while read _line; do
      if [[ -n "${_line}" ]]; then
        ln -sf ${_line}
      fi
    done < ${links}
  done
fi
