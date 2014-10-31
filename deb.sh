mkdir -p home/dashing
cp -r Gemfile home/dashing/
cp -r README.md home/dashing/
cp -r assets home/dashing/
cp -r config.ru home/dashing/
cp -r dashboards home/dashing/
cp -r jobs home/dashing/
cp -r pass home/dashing/
cp -r public home/dashing/
cp -r scripts home/dashing/
cp -r widgets home/dashing/
cd home/dashing
bundle install --path=. --binstubs --deployment --standalone
cd ../../
mkdir -p etc/init.d
cp init.sh etc/init.d/dashing
chmod 755 etc/init.d/dashing
