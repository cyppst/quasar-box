FROM runmymind/docker-android-sdk:latest

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# Hopefully just a temporary patch: https://github.com/google/filament/issues/15
RUN rm -fr /opt/android-sdk-linux/ndk-bundle

RUN apt-get update \
 && apt-get install gnupg gradle -y \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install nodejs npm yarn -y \
 && yarn global add cordova@^8.0.0 \
 && apt-get clean \
 && npm install -g quasar-cli

WORKDIR "/opt/tools"
RUN ./entrypoint.sh built-in

VOLUME /src
WORKDIR /src

