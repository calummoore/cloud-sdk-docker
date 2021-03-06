FROM google/debian:wheezy
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y -qq --no-install-recommends wget unzip python php5-mysql php5-cli php5-cgi openjdk-7-jre-headless openssh-client python-openssl && apt-get clean
RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.zip && unzip google-cloud-sdk.zip && rm google-cloud-sdk.zip
ENV CLOUDSDK_PYTHON_SITEPACKAGES 1
RUN google-cloud-sdk/install.sh --usage-reporting=true --path-update=true --bash-completion=true --rc-path=/.bashrc --disable-installation-options
RUN google-cloud-sdk/bin/gcloud --quiet components update pkg-go pkg-python pkg-java preview alpha beta app
RUN google-cloud-sdk/bin/gcloud --quiet config set component_manager/disable_update_check true

RUN google-cloud-sdk/bin/gcloud components update -qq
RUN wget https://get.docker.com/builds/Linux/x86_64/docker-1.6.2 -O /usr/bin/docker \
    && chmod +x /usr/bin/docker

RUN mkdir /.ssh
ENV PATH /google-cloud-sdk/bin:$PATH
ENV HOME /
VOLUME ["/.config"]
CMD ["/bin/bash"]
