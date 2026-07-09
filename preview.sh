#!/bin/sh

set -e

sh build.sh

cd public
python3 -m http.server 8000
