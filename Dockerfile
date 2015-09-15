from ubuntu
RUN apt-get update
RUN chmod +x /root/
RUN apt-get update
RUN apt-get -y install curl
RUN apt-get -y install python

ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 4.0.0

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && mkdir -p /root/.nvm/versions/ \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/versions/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/v$NODE_VERSION/bin:$PATH

RUN apt-get -y install phantomjs --fix-missing
RUN npm install phantom
RUN apt-get -y install build-essential
RUN npm install weak
RUN npm install -g node-inspector
EXPOSE 8080
EXPOSE 5858
ENTRYPOINT ["node-debug","--debug-brk","--web-host 0.0.0.0","--cli"]
