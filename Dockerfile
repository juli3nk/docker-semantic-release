ARG NODE_VERSION="23.3.0-alpine3.20"
FROM node:${NODE_VERSION} AS build

WORKDIR /npm
COPY package.json /npm

RUN npm install


FROM node:${NODE_VERSION}

COPY --from=build /npm /npm
COPY docker-entrypoint.sh /

RUN apk --update --no-cache add \
    git \
    git-lfs \
    openssh-client \
    bash \
    jq \
    curl

# fix ENOGITREPO Not running from a git repository.
RUN git config --global --add safe.directory '*'

ENV PATH="$PATH:/npm/node_modules/.bin"
WORKDIR /data

LABEL org.opencontainers.image.source=https://github.com/juli3nk/docker-semantic-release

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD [ "--dry-run" ]
