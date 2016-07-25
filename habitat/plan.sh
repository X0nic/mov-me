pkg_name=mov-me
pkg_version=0.0.1
pkg_origin=x0nic
pkg_maintainer="Nathan Lee <nathan@globalphobia.com"
pkg_license=('mit')
pkg_source=false

pkg_deps=(
  core/coreutils/8.24
  core/ruby
)

pkg_build_deps=(
  core/bundler
  core/cacerts
  core/coreutils/8.24
  core/git
  core/gcc
  core/make
)

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_expose=(9292)


do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

# do_prepare() {
#   # Create a Gemfile with what we need
#   cat > config.ru <<GEMFILE
# source 'https://rubygems.org'
# gem 'sinatra'
# GEMFILE
# }

do_build() {
  export BUNDLE_SILENCE_ROOT_WARNING=1 GEM_PATH
  GEM_PATH="$(pkg_path_for core/bundler)"
  mkdir -p $pkg_prefix
  cp -a "$PLAN_CONTEXT/.." "$pkg_prefix"
  cd $pkg_prefix
  rm -rf .git
  rm -rf results
  bundle install --jobs "$(nproc)" --retry 5 --standalone \
    --path "$pkg_prefix/bundle" \
    --binstubs "$pkg_prefix/bin"
}

do_install() {
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
}
