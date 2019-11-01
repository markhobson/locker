#!/usr/bin/env bats

load shared
DOCKERFILE=$BATS_TMPDIR/Dockerfile

@test "Can unlock Dockerfile FROM" {
  echo "FROM openjdk@sha256:cd4feac41774690c335c8cf512fcb991ce9b0acdeaf5c4ce209b4a15bca03f83" > $DOCKERFILE
  run $LOCKER --unlock $DOCKERFILE
  [ "$status" -eq 0 ]
  grep -q '^FROM openjdk$' $DOCKERFILE
}

@test "Can unlock Dockerfile FROM with slash" {
  echo "FROM oracle/openjdk@sha256:cd4feac41774690c335c8cf512fcb991ce9b0acdeaf5c4ce209b4a15bca03f83" > $DOCKERFILE
  run $LOCKER --unlock $DOCKERFILE
  [ "$status" -eq 0 ]
  grep -q '^FROM oracle/openjdk$' $DOCKERFILE
}

@test "Can unlock Dockerfile FROM with tag" {
  echo "FROM openjdk:8@sha256:cd4feac41774690c335c8cf512fcb991ce9b0acdeaf5c4ce209b4a15bca03f83" > $DOCKERFILE
  run $LOCKER --unlock $DOCKERFILE
  [ "$status" -eq 0 ]
  grep -q '^FROM openjdk:8$' $DOCKERFILE
}

@test "Can unlock Dockerfile FROM with AS" {
  echo "FROM openjdk@sha256:cd4feac41774690c335c8cf512fcb991ce9b0acdeaf5c4ce209b4a15bca03f83 AS myjdk" > $DOCKERFILE
  run $LOCKER --unlock $DOCKERFILE
  [ "$status" -eq 0 ]
  grep -q '^FROM openjdk AS myjdk$' $DOCKERFILE
}
