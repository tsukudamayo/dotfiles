FROM spikerlabs/scala-sbt:scala-2.12.7-sbt-1.2.6
ENV LANG jp_JP.UTF-8

RUN mkdir -p /workspace
RUN apk update \
  && apk add --no-cache git ca-certificates emacs fontconfig \
  && git clone https://github.com/tsukudamayo/dotfiles.git \
  && cp -r ./dotfiles/linux/.emacs.d ~/ \
  && cp -r ./dotfiles/.fonts /usr/share/fonts \
  && fc-cache -fv

WORKDIR /workspace
CMD ["bin/sh"]
