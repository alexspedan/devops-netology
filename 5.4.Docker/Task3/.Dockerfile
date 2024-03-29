FROM node

ADD https://github.com/simplicitesoftware/nodejs-demo/archive/master.zip /

RUN unzip master.zip && \
    cd /nodejs-demo-master && \
    npm install

EXPOSE 3000/tcp

WORKDIR "/nodejs-demo-master"
CMD ["start", "0.0.0.0"]
ENTRYPOINT ["npm"]