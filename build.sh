#!/usr/bin/env bash

OPENSCAD_EXE=/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD

get_script_dir() {
  SOURCE="${BASH_SOURCE[0]}"
  SOURCE_DIR=$(dirname "${SOURCE}")
  SOURCE_DIR=$(cd -P "${SOURCE_DIR}" && pwd)
  echo "${SOURCE_DIR}"
}

set -euo pipefail

cd "$(get_script_dir)"

$OPENSCAD_EXE -v

set +e

function build() {
  FILESTEM=$1;
  # known spurious warning: https://github.com/openscad/openscad/issues/2888
  $OPENSCAD_EXE --export-format binstl -o "output/${FILESTEM}.stl" $FILESTEM.scad 2>&1 | grep -v 'Fontconfig warning'
  RESULT=$?

  if [[ "$RESULT" == "0" ]]; then
    echo "Built ${FILESTEM} OK"
  else
    echo "BUILD FAILURE of ${FILESTEM}"
  fi

  open -a Preview "output/${FILESTEM}.stl"
  echo "${FILESTEM} done"
}

build FanRemoteHolder
build AirConRemoteHolder