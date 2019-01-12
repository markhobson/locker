#!/usr/bin/env bats

load shared
DOCKERFILE=$BATS_TMPDIR/Dockerfile

@test "Can lock Dockerfile FROM" {
  echo "FROM openjdk" > $DOCKERFILE
  run $LOCKER $DOCKERFILE
  [ "$status" -eq 0 ]
  grep -q '^FROM openjdk@sha256:[a-z0-9]\{64\}$' $DOCKERFILE
}

@test "Can lock Dockerfile FROM with slash" {
  echo "FROM oracle/openjdk" > $DOCKERFILE
  run $LOCKER $DOCKERFILE
  [ "$status" -eq 0 ]
  grep -q '^FROM oracle/openjdk@sha256:[a-z0-9]\{64\}$' $DOCKERFILE
}

@test "Can lock Dockerfile FROM with tag" {
  echo "FROM openjdk:8" > $DOCKERFILE
  run $LOCKER $DOCKERFILE
  [ "$status" -eq 0 ]
  grep -q '^FROM openjdk@sha256:[a-z0-9]\{64\}$' $DOCKERFILE
}

@test "Can lock Dockerfile FROM with AS" {
  echo "FROM openjdk AS myjdk" > $DOCKERFILE
  run $LOCKER $DOCKERFILE
  [ "$status" -eq 0 ]
  grep -q '^FROM openjdk@sha256:[a-z0-9]\{64\} AS myjdk$' $DOCKERFILE
}
