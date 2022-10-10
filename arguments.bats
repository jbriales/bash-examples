#!/usr/bin/env bats

load /usr/local/lib/bats-support/load.bash
load /usr/local/lib/bats-assert/load.bash

@test "save args into string" {
  set -- \
    --foo=$'bar\nquz' \
    --xox=baz \
    --xax=boz

  argv=("$@")

  export var="$(IFS=$'\x1E'; echo "$*")"$'\x1E'

  arr=()
  while read -d $'\x1E' line; do
    arr+=("$line")
  done <<<"$var"

  assert_equal "${arr[0]}" "${argv[0]}" 
  assert_equal "${arr[1]}" "${argv[1]}" 
  assert_equal "${arr[2]}" "${argv[2]}" 
}