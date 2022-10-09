#!/usr/bin/env bats

load /usr/local/lib/bats-support/load.bash
load /usr/local/lib/bats-assert/load.bash

@test "read args one at a time - while read" {
  wrapper ()(
    while read line; do
      echo "Input: $line";
    done <<<$'foo\nbar\nquz'
  )
  run wrapper
  assert_output "$(cat <<EOF
Input: foo
Input: bar
Input: quz
EOF
)"
}