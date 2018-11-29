
FROM runmymind/docker-android-sdk:latest

LABEL maintainer="golfcomsci@outlook.com"

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

EXPOSE 7484
# Hopefully just a temporary patch: https://github.com/google/filament/issues/15
RUN rm -fr /opt/android-sdk-linux/ndk-bundle

RUN apt-get update \
 && apt-get install gnupg gradle -y \
 && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && apt-get update \
 && apt-get install nodejs npm yarn ftp-upload webhook -y \
 && yarn global add cordova@^8.0.0 \
 && apt-get clean \
 && npm install -g quasar-cli

WORKDIR "/opt/tools"
RUN ./entrypoint.sh built-in

RUN git config --global user.email "golfcomsci@outlook.com" && git config --global user.name "Golfcomsci"
COPY ./scripts/hooks.json /
COPY ./scripts/webhook.sh /usr/local/bin
COPY ./scripts/quasar-build.sh /usr/local/bin
RUN chmod 777 /usr/local/bin/*.sh
RUN mkdir /src
WORKDIR /src

#CMD dir
#CMD "webhook /hooks.json"
#CMD "/usr/bin/webhook -hooks /hooks.json -hotreload -verbose -port 7484&"
#CMD webhook -hooks /hooks.json -hotreload -verbose -port 7484   
#WORKDIR /
#ENTRYPOINT  ["/usr/bin/webhook"]
CMD /usr/bin/webhook -hooks /hooks.json -hotreload -verbose -port 7484
#CMD ["-verbose", "-hooks=/hooks.json", "-hotreload","-port 7484"]
#RUN mkdir /src
#WORKDIR /src
#WORKDIR /src
