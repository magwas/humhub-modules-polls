FROM ubuntu:bionic
RUN apt-get -y update
RUN export DEBIAN_FRONTEND=noninteractive; apt-get -y upgrade
RUN export DEBIAN_FRONTEND=noninteractive; apt-get -y install \
    php7.2-zip php7.2-gd php7.2-curl php7.2-mbstring php7.2-ldap \
    php7.2-intl mysql-server composer vim less php7.2-dom git \
    curl npm grunt php7.2-mysql sudo unzip chromium-browser \
    libglib2.0-0 libnss3
RUN sed 's/.ALL:ALL./(ALL) NOPASSWD:/' -i /etc/sudoers
RUN groupadd -g 1000 travis
RUN useradd -u 1000 -g 1000 -G sudo -d /Humhub travis
RUN service mysql start;mysql -e 'create user travis; grant all on *.* to travis'
RUN curl -s -L -o chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/2.38/chromedriver_linux64.zip \
    && unzip -o -d $HOME chromedriver_linux64.zip \
        && chmod +x $HOME/chromedriver
RUN composer global require fxp/composer-asset-plugin
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN mkdir -p /opt/humhub
RUN cd /opt/humhub;git clone --depth 1 https://github.com/humhub/humhub.git .
RUN cd /opt/humhub; composer install --prefer-dist --no-interaction
RUN cd /opt/humhub; npm install -g grunt-cli
RUN cd /opt/humhub; npm install;npm audit fix
RUN cd /opt/humhub; grunt build-assets
RUN chown -R travis.travis /opt/humhub
CMD /bin/bash


