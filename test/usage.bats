#!/usr/bin/env bats

load shared

@test "Can show usage" {
  run $LOCKER
  [ "$status" -eq 1 ]
  [ "${lines[0]}" = "Usage: locker [-u | --unlock] FILE" ]
}
