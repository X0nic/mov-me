FROM ruby:2.1-onbuild

RUN wget https://yt-dl.org/latest/youtube-dl -O /usr/local/bin/youtube-dl && \
    chmod a+x /usr/local/bin/youtube-dl && \
    hash -r

CMD ["rackup", "-o", "0.0.0.0"]
