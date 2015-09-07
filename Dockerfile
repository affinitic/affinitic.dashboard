FROM ubuntu:14.04

WORKDIR /dashing
RUN apt-get update && apt-get install -y libxml2-dev ruby ruby-dev make gcc g++ zlib1g zlib1g-dev libxml2 liblzma-dev libxslt-dev software-properties-common python-software-properties
COPY Gemfile /dashing/Gemfile
COPY config.ru /dashing/config.ru
ENV HOME=/dashing
RUN gem install dashing
RUN gem install bundler 
RUN gem install nokogiri -q --no-rdoc --no-ri -v "1.6.5" -- --use-system-libraries --with-xml2-include=/usr/include/libxml2
RUN bundle config build.nokogiri --use-system-libraries --with-xml2-include=/usr/include/libxml2
RUN NOKOGIRI_USE_SYSTEM_LIBRARIES=1 bundle install

RUN mkdir -p /dashing && \
    dashing new dashing && \
    cd /dashing && bundle && \
    ln -s /dashing/dashboards /dashboards && \
    ln -s /dashing/jobs /jobs && \
    ln -s /dashing/public /public && \
    ln -s /dashing/widgets /widgets && \
    mkdir /dashing/config && \
    mv /dashing/config.ru /dashing/config/config.ru && \
    ln -s /dashing/config/config.ru /dashing/config.ru && \
    ln -s /dashing/config /config

COPY run.sh /

#nodejs
RUN apt-get install -y python-software-properties
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update
RUN apt-get install -y nodejs

VOLUME ["/dashboards", "/jobs", "/config", "/public", "/widgets"]

ENV PORT 3030
EXPOSE $PORT

CMD ["/run.sh"]
