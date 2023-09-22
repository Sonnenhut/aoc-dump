#!/bin/bash
set -eux

# taken from: https://www.reddit.com/r/adventofcode/comments/rgo4m9/is_there_a_script_to_download_all_the_current/holk8cw/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
# usage:
# ./download.sh 'session=xxx' > /dev/null 2>&1 &


COOKIE=${1:-'undefined'}

url="https://adventofcode.com"

mkdir -p static
curl "${url}/static/style.css" > static/style.css

curl --cookie "${COOKIE}" "${url}" > index.html

for y in {2015..2022}
  do    
    mkdir -p ${y}/events
    mkdir -p ${y}/day
    curl --cookie "${COOKIE}" "${url}/${y}" > ${y}/index.html
    curl --cookie "${COOKIE}" "${url}/${y}/events" > ${y}/events/index.html
    for i in $(seq 25)
    do
      mkdir -p ${y}/day/${i}
      curl --cookie "${COOKIE}" "${url}/${y}/day/${i}" > ${y}/day/${i}/index.html
      curl --cookie "${COOKIE}" "${url}/${y}/day/${i}/input" > ${y}/day/${i}/input
      # when serving the index files, they will already have /day/1/, plus /1/input
      mkdir -p ${y}/day/${i}/${i}
      cp ${y}/day/${i}/input ${y}/day/${i}/${i}/input
    done
done
