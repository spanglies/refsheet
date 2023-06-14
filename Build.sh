#!/bin/bash

python Build.py
echo $CF_PAGES_URL
if [[ "$CF_PAGES_BRANCH" == "master" ]] || [[ -z $CF_PAGES_URL ]]
then
  cat ./base_url >> config.toml
else
  echo "base_url = \"$CF_PAGES_URL\"" >> config.toml
fi
cat config.base.toml >> config.toml
yarn build
python uploadZip.py
cp -r public publish
rm config.toml
rm -r publish/zips