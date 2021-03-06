#!/bin/bash -xe

mkdir -p home/dashing
cp -r Gemfile home/dashing/
cp -r Gemfile.lock home/dashing/
cp -r README.md home/dashing/
cp -r assets home/dashing/
cp -r config.ru home/dashing/
cp -r dashboards home/dashing/
cp -r jobs home/dashing/
cp -r lib home/dashing/
cp -r pass home/dashing/
cp -r public home/dashing/
cp -r scripts home/dashing/
cp -r widgets home/dashing/
cd home/dashing
bundle install --path=. --binstubs --deployment --standalone
cd ../../
mkdir -p etc/systemd/system
cp dashing.unit etc/systemd/system
