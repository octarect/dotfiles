FROM civo/cli:latest

ARG CONF_UID=9001
ARG CONF_GID=9001

USER root

RUN apk add --update --no-cache --virtual .deps curl shadow

# Add kubectl for `civo k8s`
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
 && chmod +x ./kubectl \
 && mv ./kubectl /usr/local/bin/kubectl

# Modify UID and GID
RUN usermod -u $CONF_UID -o user

# Clean up
RUN apk del .deps

USER user
