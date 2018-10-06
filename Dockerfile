FROM ubuntu:latest
# prep work
ENV HOME /home
WORKDIR /home
RUN apt-get update \
  && apt-get install -y curl man gcc g++ build-essential make vim emacs git;

# install node, npm, yarn
RUN curl -sL https://deb.nodesource.com/setup_8.x | sh \
  && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg \
  | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" \
  | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update && apt-get install yarn \
  && npm i -g webpack parcel rollup @vue/cli mocha

# install anaconda @ python 3.7
RUN curl -O https://repo.continuum.io/archive/Anaconda3-5.3.0-Linux-x86.sh \
  && echo "4321e9389b648b5a02824d4473cfdb5f Anaconda3-5.3.0-Linux-x86.sh" \
  | md5sum - \
  && sh Anaconda2-5.3.0-Linux-x86.sh \
  && pip install black yapf pycodestyle pydocstyle mypy

# possible: install neo4j, postgres, python language server? other languages?
CMD ["bash"]
