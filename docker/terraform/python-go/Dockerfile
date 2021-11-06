FROM python:3.9-alpine3.13

ENV GO111MODULE=on
ENV DISPLAY=host.docker.internal:0.0
ENV PATH $PATH:/root/.poetry/bin
ENV PATH $PATH:/usr/local/go/bin
ENV GOPATH /go
ENV PATH $GOPATH/bin:$PATH
ENV PATH /root/.tfenv/bin:$PATH

ARG TERRAFORM_VERSION="0.14.8"

RUN apk add --update --no-cache bash \
    curl \
    wget \
    zip \
    unzip \
    git \
    go \
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin/ \
    && rm -rf ./terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && git clone https://github.com/tfutils/tfenv.git ~/.tfenv \
    && pip install awscli \
    && mkdir -p /go \
    && mkdir -p "$GOPATH/src" "$GOPATH/bin" \
    && chmod -R 777 "$GOPATH"

WORKDIR $GOPATH

EXPOSE 8080

CMD ["/bin/bash"]
