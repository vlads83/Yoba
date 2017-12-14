FROM alpine:3.4

# Update
RUN apk add --update nodejs

# Install app dependencies
COPY package.json /src/package.json
RUN cd /src; npm install

# Bundle app source
COPY . /src

EXPOSE  8080
RUN ["chmod", "+x", "/src/entrypoint.sh"]
#ENTRYPOINT ["/src/entrypoint.sh"]
