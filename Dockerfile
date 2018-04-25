FROM ubuntu:16.04

LABEL maintainer="Adithya Seshadri <a.seshadri@samsung.com>"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 BAZELRC=/root/.bazelrc BAZEL_VERSION=0.5.4

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
      python-dev \
      python-pip \
      python-setuptools \
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
    rm -rf /var/lib/apt/lists/*

RUN pip --no-cache-dir install --upgrade pip \
        mock \
        grpcio \
        virtualenv \
        tensorflow \
        sklearn \
        pandas \
        scipy \
        jupyter \
        notebook \
        tensorflow-serving-api

EXPOSE 8888
WORKDIR /

RUN mkdir /bazel && \
    cd /bazel && \
    curl -fSsL -O https://github.com/bazelbuild/bazel/releases/download/$BAZEL_VERSION/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    curl -fSsL -o /bazel/LICENSE.txt https://raw.githubusercontent.com/bazelbuild/bazel/master/LICENSE && \
    chmod +x bazel-*.sh && \
    ./bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    cd / && \
    rm -f /bazel/bazel-$BAZEL_VERSION-installer-linux-x86_64.sh && \
    echo "deb [arch=amd64] http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | tee /etc/apt/sources.list.d/tensorflow-serving.list && \
    curl https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | apt-key add - && \
    apt-get update && apt-get install -y tensorflow-model-server && \
    apt-get upgrade -y tensorflow-model-server


CMD ["/bin/bash"]
