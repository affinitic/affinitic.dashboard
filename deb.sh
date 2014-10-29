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
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers dashing -- --ruby=/usr/bin/ruby1.9.1 --version=1.3.4
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers rest-client -- --ruby=/usr/bin/ruby1.9.1 --version=1.7.2
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers google-api-client -- --ruby=/usr/bin/ruby1.9.1 --version=0.7.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers nokogiri -- --with-xml2-include=/usr/include/libxml2 --use-system-libraries --ruby=/usr/bin/ruby1.9.1 --version=1.6.3.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers htmlentities -- --ruby=/usr/bin/ruby1.9.1 --version=4.3.2
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers httparty -- --ruby=/usr/bin/ruby1.9.1 --version=0.13.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers nagiosharder -- --ruby=/usr/bin/ruby1.9.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers github_api -- --ruby=/usr/bin/ruby1.9.1 --version=0.11.3
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers twitter -- --ruby=/usr/bin/ruby1.9.1 --version=5.11.0
# Missing dependencies for dashing
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers backports -- --ruby=/usr/bin/ruby1.9.1 --version=3.6.3
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers extlib -- --ruby=/usr/bin/ruby1.9.1 --version=0.9.16
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers json -- --ruby=/usr/bin/ruby1.9.1 --version=1.8.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers multi_json -- --ruby=/usr/bin/ruby1.9.1 --version=1.10.1
GEM_HOME=home/dashing gem install --no-ri --no-rdoc --wrappers thor -- --ruby=/usr/bin/ruby1.9.1 --version=0.18.1
mkdir -p etc/init.d
cat <<EOF >etc/init.d/dashing
#!/bin/sh
set -e
export GEM_HOME="/home/dashing"
exec \${GEM_HOME}/bin/dashing \$@
EOF
chmod 755 etc/init.d/dashing
