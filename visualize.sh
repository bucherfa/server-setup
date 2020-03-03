#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd $SCRIPT_DIR
# iterate over folders - https://stackoverflow.com/a/2108296
for dir in $PWD/*/
do
  dir=${dir%*/}
  cd $dir
  docker run --rm -it --name dcv -v $(pwd):/input pmsipilot/docker-compose-viz render -f -o architecture.png -m image docker-compose.yml
done
