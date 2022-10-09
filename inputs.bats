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

@test "read args one at a time - while read with free stdin" {
  wrapper ()(
    while read <&3 line; do
      read -n1  # this is the user-interactive part, mocked by 'yyy' below
      echo "Input: $line";
    done 3<<<$'foo\nbar\nquz' <<<'yyy'
  )
  run wrapper
  assert_output "$(cat <<EOF
Input: foo
Input: bar
Input: quz
EOF
)"
}