#!/bin/bash
set -eux

# taken from: https://www.reddit.com/r/adventofcode/comments/rgo4m9/is_there_a_script_to_download_all_the_current/holk8cw/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
# usage:
# ./download.sh 'session=xxx' 2022 > /dev/null 2>&1 &


COOKIE=${1:-'undefined'}
YEAR=${2:-'2015'}

url="https://adventofcode.com"
url_day="${url}/${YEAR}/day"

mkdir -p static
curl "${url}/static/style.css" > static/style.css

mkdir -p ${YEAR}/day
cd ${YEAR}/day

for i in $(seq 25)
do
  mkdir -p $i
  curl "${url_day}/${i}" > ${i}/index.html
  curl --cookie "${COOKIE}" "${url_day}/${i}/input" > ${i}/input
done
