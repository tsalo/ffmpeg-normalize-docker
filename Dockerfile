# ffmpeg - http://ffmpeg.org/download.html
#
# Adapted from jrottenberg/ffmpeg:3.3-alpine
# (https://hub.docker.com/r/jrottenberg/ffmpeg/)
# to include ffmpeg-normalize
#

FROM        jrottenberg/ffmpeg:3.3-alpine AS base

RUN     apk  add --no-cache --update libgcc libstdc++ ca-certificates libcrypto1.1 libssl1.1 libgomp expat git


FROM        base AS build

WORKDIR     /tmp/workdir


### Release Stage
FROM        base AS release
MAINTAINER  Julien Rottenberg <julien@rottenberg.info>

CMD         ["--help"]
ENTRYPOINT  [""]

COPY --from=build /usr/local /usr/local

RUN     buildDeps="python3" && \
        apk  add --no-cache --update ${buildDeps}

# Elements added for ffmpeg-normalize
RUN pip3 install ffmpeg-normalize

# Let's make sure the app built correctly
# Convenient to verify on https://hub.docker.com/r/jrottenberg/ffmpeg/builds/ console output
