FROM ubuntu:14.04

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
        g++ \
        gcc \
        libc6-dev \
        curl \
        ctags \
        ca-certificates \
        mercurial \
        make \
    && rm -rf /var/lib/apt/lists/*

ENV GOLANG_VERSION 1.5.4
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 a3358721210787dc1e06f5ea1460ae0564f22a0fbd91be9dcd947fb1d19b9560

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
    && echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
    && tar -C /usr/local -xzf golang.tar.gz \
    && rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
ENV GOBIN $GOPATH/bin

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

RUN apt-get -y update && apt-get install -y vim git
RUN git clone https://github.com/airk000/vimrc.git ~/.vim_runtime
RUN chmod +x ~/.vim_runtime/install_awesome_vimrc.sh
RUN sh ~/.vim_runtime/install_awesome_vimrc.sh

