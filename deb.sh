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
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers dashing --version=1.3.4 -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers rest-client --version=1.7.2 -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers google-api-client --version=0.7.1 -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers nokogiri --version=1.6.3.1 -- --with-xml2-include=/usr/include/libxml2 --use-system-libraries --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers htmlentities --version=4.3.2 -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers httparty --version=0.13.1 -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers nagiosharder -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers github_api --version=0.11.3 -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers twitter --version=5.11.0 -- --ruby=/usr/bin/ruby1.9.1
# Missing dependencies for dashing
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers backports --version=3.6.3 -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers extlib --version=0.9.16 -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers json --version=1.8.1 -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers multi_json --version=1.10.1 -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers thor --version=0.18.1 -- --ruby=/usr/bin/ruby1.9.1
mkdir -p etc/init.d
cat <<EOF >etc/init.d/dashing
#!/bin/sh
set -e
export GEM_HOME="/home/dashing"
exec \${GEM_HOME}/bin/dashing \$@
EOF
chmod 755 etc/init.d/dashing
