FROM alpine:latest
LABEL maintainer="it-operations@boerse-go.de"
ENV TOOL=consul \
    VERSION=1.7.2 \
    SHA256=5ab689cad175c08a226a5c41d16392bc7dd30ceaaf90788411542a756773e698

# By using ADD there is no need to install wget or curl
ADD https://releases.hashicorp.com/${TOOL}/${VERSION}/${TOOL}_${VERSION}_linux_amd64.zip ${TOOL}_${VERSION}_linux_amd64.zip
RUN echo "${SHA256}  ${TOOL}_${VERSION}_linux_amd64.zip" | sha256sum -cw &&\
    unzip ${TOOL}_${VERSION}_linux_amd64.zip &&\
    rm -r ${TOOL}_${VERSION}_linux_amd64.zip

# additional software for health checks of services
RUN apk --no-cache add curl monitoring-plugins

ENTRYPOINT ["/consul"]
