FROM ruby:2.1-onbuild

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
         libav-tools \
      && rm -rf /var/lib/apt/lists/*

RUN wget https://yt-dl.org/latest/youtube-dl -O /usr/local/bin/youtube-dl && \
    chmod a+x /usr/local/bin/youtube-dl && \
    hash -r

CMD ["foreman", "start"]
