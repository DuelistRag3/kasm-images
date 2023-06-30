ARG BASE_TAG="develop"
FROM kasmweb/core-ubuntu-bionic:$BASE_TAG

USER root

ENV HOME /home/kasm-default-profile
ENV STARTUPDIR /dockerstartup
WORKDIR $HOME

### Envrionment config
ENV DEBIAN_FRONTEND noninteractive
ENV KASM_RX_HOME $STARTUPDIR/kasmrx
ENV INST_SCRIPTS $STARTUPDIR/install

######### Customize Container Here ###########

### Envrionment config
ENV DEBIAN_FRONTEND=noninteractive \
    SKIP_CLEAN=true \
    KASM_RX_HOME=$STARTUPDIR/kasmrx \
    DONT_PROMPT_WSL_INSTALL="No_Prompt_please" \
    INST_DIR=$STARTUPDIR/install \
    INST_SCRIPTS="/ubuntu/install/tools/install_tools_deluxe.sh \
                  /ubuntu/install/misc/install_tools.sh \
                  /ubuntu/install/misc/install_mariadb-server.sh \
                  /ubuntu/install/chrome/install_chrome.sh \
                  /ubuntu/install/nextcloud/install_nextcloud.sh \
                  /ubuntu/install/composer/install_composer.sh \
                  /ubuntu/install/vs_code/install_vs_code.sh"

### Install Tools
COPY ./src/ubuntu/install/tools $INST_SCRIPTS/tools/
RUN bash $INST_SCRIPTS/tools/install_tools_deluxe.sh  && rm -rf $INST_SCRIPTS/tools/

# Install Utilities
COPY ./src/ubuntu/install/misc $INST_SCRIPTS/misc/
RUN bash $INST_SCRIPTS/misc/install_tools.sh && rm -rf $INST_SCRIPTS/misc/

### Install Google Chrome
COPY ./src/ubuntu/install/chrome $INST_SCRIPTS/chrome/
RUN bash $INST_SCRIPTS/chrome/install_chrome.sh  && rm -rf $INST_SCRIPTS/chrome/

# Install Firefox
COPY ./src/ubuntu/install/firefox/ $INST_SCRIPTS/firefox/
COPY ./src/ubuntu/install/firefox/firefox.desktop $HOME/Desktop/
RUN bash $INST_SCRIPTS/firefox/install_firefox.sh && rm -rf $INST_SCRIPTS/firefox/


### Install Visual Studio Code
COPY ./src/ubuntu/install/vs_code $INST_SCRIPTS/vs_code/
RUN bash $INST_SCRIPTS/vs_code/install_vs_code.sh  && rm -rf $INST_SCRIPTS/vs_code/


### Install Slack
COPY ./src/ubuntu/install/slack $INST_SCRIPTS/slack/
RUN bash $INST_SCRIPTS/slack/install_slack.sh  && rm -rf $INST_SCRIPTS/slack/


### Install NextCloud
COPY ./src/ubuntu/install/nextcloud $INST_SCRIPTS/nextcloud/
RUN bash $INST_SCRIPTS/nextcloud/install_nextcloud.sh  && rm -rf $INST_SCRIPTS/nextcloud/

### Install Teams
COPY ./src/ubuntu/install/teams $INST_SCRIPTS/teams/
RUN bash $INST_SCRIPTS/teams/install_teams.sh  && rm -rf $INST_SCRIPTS/teams/

### Install Only Office
COPY ./src/ubuntu/install/only_office $INST_SCRIPTS/only_office/
RUN bash $INST_SCRIPTS/only_office/install_only_office.sh  && rm -rf $INST_SCRIPTS/only_office/

### Remove maxmius
RUN apt-get remove -y maximus

# sudo support
RUN apt-get update \
    && apt-get install -y sudo \
    && echo 'kasm-user ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && rm -rf /var/lib/apt/list/*

# Install PHP
RUN apt-get update && apt-get install -y \
        libpng-dev \
        zlib1g-dev \
        libxml2-dev \
        libzip-dev \
        libonig-dev \
        libpq-dev \
        zip \
        curl \
        unzip \
        php \
        php-mysqli \
        php-mysql \
        php-zip \
        php-exif \
        php-pdo \
        php-curl \
        php-pgsql

#ADD ./src/common/scripts $STARTUPDIR
RUN $STARTUPDIR/set_user_permission.sh $HOME

RUN chown 1000:0 $HOME

ENV HOME /home/kasm-user
WORKDIR $HOME
RUN mkdir -p $HOME && chown -R 1000:0 $HOME

USER 1000

CMD ["--tail-log"]