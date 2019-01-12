FROM ubuntu:latest
# prep work
ENV HOME /home
WORKDIR /home
RUN apt-get update \
  && apt-get install -y \
    build-essential \
    curl \
    default-jdk \
    emacs \
    git \
    gcc \
    g++ \
    make \
    man \
    vim \
    wget \
  ;

# install node, npm, yarn
RUN curl -sL https://deb.nodesource.com/setup_10.x | sh \
  && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg \
  | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" \
  | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install -y yarn \
  && npm i -g webpack parcel rollup @vue/cli mocha

# install anaconda @ python 3.7
# TODO: join these commands
ENV bootstrap_conda=". /opt/conda/etc/profile.d/conda.sh"
ENV PATH=/opt/conda/bin:$PATH
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O ~/anaconda.sh \
  && /bin/bash ~/anaconda.sh -b -p /opt/conda \
  && rm ~/anaconda.sh \
  && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
  && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
  && echo "conda activate base" >> ~/.bashrc \
  && $bootstrap_conda && conda activate base

RUN pip install black yapf pycodestyle pydocstyle mypy

# possible: install neo4j, postgres, python language server? other languages?
CMD ["bash"]
