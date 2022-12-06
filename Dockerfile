#simple jib-cli docker installation
FROM eclipse-temurin:17

ARG USER_HOME_DIR="/tmp"
ARG APP_DIR="/app"
ARG USER_ID=1000

ENV HOME "$USER_HOME_DIR"
ENV PATH "$PATH:/opt/jib/bin"

WORKDIR $APP_DIR

RUN apt-get update && apt-get install -qqy --no-install-recommends \
    ca-certificates \
    procps \
    rsync \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG JIB_CLI_VERSION=0.12.0
LABEL jib-cli=$JIB_CLI_VERSION

RUN set -xe \
    && curl -sSL -o jib.zip https://github.com/GoogleContainerTools/jib/releases/download/v${JIB_CLI_VERSION}-cli/jib-jre-${JIB_CLI_VERSION}.zip \
    && unzip jib.zip  \
    && rm jib.zip \
    && mv jib-${JIB_CLI_VERSION} /opt/jib

USER $USER_ID
