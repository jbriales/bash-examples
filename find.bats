#!/usr/bin/env bats

load /usr/local/lib/bats-support/load.bash
load /usr/local/lib/bats-assert/load.bash

@test "delete files" {
  cd "$BATS_TEST_TMPDIR"

  touch foo bar quz

  find -delete
  run ls -A
  assert_output ""
}