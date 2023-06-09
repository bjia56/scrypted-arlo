#!/bin/bash

PYTHON3_VERSION=$1

set -e

build_wheel() (
    PY_VER=$1
    mkdir build$PY_VER
    cd build$PY_VER
    pip$PY_VER wheel ..
)

test_wheel() (
    PY_VER=$1
    cd build$PY_VER
    pip$PY_VER install *armv7l.whl
    python$PY_VER -c "import scrypted_arlo_go; print(scrypted_arlo_go)"
)

repair_wheel() (
    PY_VER=$1
    cd build$PY_VER
    auditwheel repair *armv7l.whl
)

build_wheel 3.$PYTHON3_VERSION
repair_wheel 3.$PYTHON3_VERSION
test_wheel 3.$PYTHON3_VERSION