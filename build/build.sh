#!/bin/sh
ATOM_VERSION='v0.210.0'
WORKSPACE="$(pwd)"
run_in_docker() {
  docker run --rm -v $WORKSPACE:$WORKSPACE --env=WORKSPACE=$WORKSPACE 192.168.59.103:5000/mrohland/atom:$ATOM_VERSION /sbin/my_init -- $@
}

run_in_docker $WORKSPACE/build/test.sh
