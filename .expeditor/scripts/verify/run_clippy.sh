#!/bin/bash

set -euo pipefail

source .expeditor/scripts/verify/shared.sh

toolchain="${1:-"$(get_toolchain)"}"
install_rustup
install_rust_toolchain "$toolchain"

# TODO: these should be in a shared script?
install_hab_pkg core/zeromq core/protobuf
export LIBZMQ_PREFIX
LIBZMQ_PREFIX=$(hab pkg path core/zeromq)
# now include zeromq so it exists in the runtime library path when cargo test is run
export LD_LIBRARY_PATH
LD_LIBRARY_PATH="$(hab pkg path core/zeromq)/lib"

# Install clippy
echo "--- :rust: Installing clippy"
rustup component add --toolchain "$toolchain" clippy

# Lints we need to work through and decide as a team whether to allow or fix
mapfile -t unexamined_lints < "$2"

# Lints we disagree with and choose to keep in our code with no warning
mapfile -t allowed_lints < "$3"

# Known failing lints we want to receive warnings for, but not fail the build
mapfile -t lints_to_fix < "$4"

# Lints we don't expect to have in our code at all and want to avoid adding
# even at the cost of failing the build
mapfile -t denied_lints < "$5"

clippy_args=()

add_lints_to_clippy_args() {
  flag=$1
  shift
  for lint
  do
    clippy_args+=("$flag" "${lint}")
  done
}

set +u # See https://stackoverflow.com/questions/7577052/bash-empty-array-expansion-with-set-u/39687362#39687362
add_lints_to_clippy_args -A "${unexamined_lints[@]}"
add_lints_to_clippy_args -A "${allowed_lints[@]}"
add_lints_to_clippy_args -W "${lints_to_fix[@]}"
add_lints_to_clippy_args -D "${denied_lints[@]}"
set -u

echo "--- Running clippy!"
cargo +"$toolchain" version
cargo +"$toolchain" clippy --version
echo "Clippy rules: cargo +$toolchain clippy --all-targets --tests -- ${clippy_args[*]}"
cargo +"$toolchain" clippy --all-targets --tests -- "${clippy_args[@]}"
