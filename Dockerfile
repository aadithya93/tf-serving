FROM ubuntu:16.04

LABEL maintainer="Adithya Seshadri <a.seshadri@samsung.com>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

#Install apt-get dependencies
RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
      build-essential \
      curl \
      libcurl3-dev \
      git \
      libfreetype6-dev \
      libpng12-dev \
      libzmq3-dev \
      pkg-config \
      pkg-config \
      python3-dev \
      python3-pip \
      python3-setuptools \
      unzip \
      software-properties-common \
      swig \
      zip \
      zlib1g-dev \
      libcurl3-dev \
      openjdk-8-jdk\
      openjdk-8-jre-headless \
      wget \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/bin/python3 /usr/bin/python

#Install python3 packages
RUN pip3 install --upgrade \
        mock \
        grpcio \
        virtualenv \
        tensorflow \
        sklearn \
        pandas \
        scipy \
        jupyter \
        notebook

# Set up Bazel.
ENV BAZELRC=/root/.bazelrc BAZEL_VERSION=0.5.4

WORKDIR /
RUN mkdir /bazel && \
    cd /bazel && \
    curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    curl -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh

CMD ["/bin/bash"]
