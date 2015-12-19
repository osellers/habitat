pkg_name=libstdc++
pkg_derivation=chef
pkg_version=5.2.1
pkg_license=('GPLv2' 'LGPLv2.1')
pkg_source=http://ftp.gnu.org/gnu/libc/${pkg_name}-${pkg_version}.tar.bz2
pkg_deps=(chef/glibc chef/libgcc)
pkg_build_deps=(chef/patchelf)
pkg_shasum=d17a843419530035e73f65e8ecf75e3bb7ea9548d3469bd67f3f769a03ee39c1
pkg_lib_dirs=(usr/lib/x86_64-linux-gnu)
pkg_gpg_key=3853DA6B

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_build() {
  dpkg -L libstdc++6 > $BLDR_SRC_CACHE/$pkg_dirname/files
}

do_install() {
  mkdir -p $pkg_path
  rsync -vaP --no-dirs --files-from=$BLDR_SRC_CACHE/$pkg_dirname/files / $pkg_path
  glibc=$(pkg_path_for "chef/glibc")
  libgcc=$(pkg_path_for "chef/libgcc")
  for lib in "$pkg_path/usr/lib/x86_64-linux-gnu/*"; do
    patchelf --set-rpath "$glibc/lib/x86_64-linux-gnu:$libgcc/lib/x86_64-linux-gnu" $lib
  done
}

do_strip() {
  return 0
}
