#!/usr/bin/env bash

function git_changelog {
  for tagname in `git tag -l`; do
    taghash=`git rev-parse $tagname`;
    git cat-file -p $taghash | awk -vRS= '!/^object/ {print $0, "\n"}'
  done
}
