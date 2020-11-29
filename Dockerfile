FROM centos:centos8

# ================================1. Primary Dev Packages================================

RUN yum makecache \
    && yum -y update \
    && yum install -y \
       curl ca-certificates gnupg2 \
       which gcc-c++ make patch readline zlib \
       mod_ssl make bzip2 autoconf \
       automake libtool bison \
       vim git

# ================================2. Other system dependencies==================

RUN yum -y install gcc wget \
       poppler-utils \
	   libtool bison mariadb
RUN yum --enablerepo=PowerTools install libyaml-devel libffi-devel sqlite-devel mysql-devel bzip2-devel zlib-devel readline-devel openssl-devel -y	

# ================================3. Dependencies for latest rails=======================

# nodejs
RUN curl -sL https://rpm.nodesource.com/setup_12.x | bash -
RUN yum install -y nodejs mutt

# yarn
RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
RUN rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg
RUN yum -y install yarn unzip

# RVM
RUN curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
RUN curl -L get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN rvm reload

# ================================4. Clean Stale Packages================================

RUN yum -y remove ruby
RUN /bin/bash -l -c "rvm install 2.7.2"
RUN /bin/bash -l -c "rvm use 2.7.2 --default"
RUN /bin/bash -l -c "gem install bundler"
ENV PATH /usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:$PATH

#===================================5.1 local settings===================================

RUN mkdir /src
WORKDIR /src
COPY package.json /src/package.json
COPY yarn.lock /src/yarn.lock
COPY Gemfile /src/Gemfile
COPY Gemfile.lock /src/Gemfile.lock
RUN ["/bin/bash", "-l", "-c", "bundle install"]
RUN /bin/bash -l -c "yarn install --check-files"
RUN yum clean all

#CMD  /bin/bash -l -c "rails s -b 0.0.0.0 -p 5000"