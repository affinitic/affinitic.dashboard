mkdir -p home/dashing
cp -r Gemfile home/dashing/
cp -r Gemfile.lock home/dashing/
cp -r README.md home/dashing/
cp -r assets home/dashing/
cp -r config.ru home/dashing/
cp -r dashboards home/dashing/
cp -r jobs home/dashing/
cp -r pass home/dashing/
cp -r public home/dashing/
cp -r scripts home/dashing/
cp -r widgets home/dashing/
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers dashing
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers rest-client
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers google-api-client
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers nokogiri -- --with-xml2-include=/usr/include/libxml2 --use-system-libraries
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers htmlentities
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers httparty
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers nagiosharder
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers github_api
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers twitter
mkdir -p etc/init.d
cat <<EOF >etc/init.d/dashing
#!/bin/sh
set -e
export GEM_HOME="/home/dashing"
exec \${GEM_HOME}/bin/dashing \$@
EOF
chmod 755 etc/init.d/dashing
fpm -s dir -t deb -C . --deb-user root --deb-group root --depends ruby1.9.3 --name dashing-affinitic --version 0.1 --description "Dashing for affinitic" home etc
