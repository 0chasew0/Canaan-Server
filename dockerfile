FROM alpine:latest

# Environment Variables
ENV RELEASE_DOWNLOAD "https://github.com/0chasew0/Canaan-Server/releases/latest/download/Linux.zip"
ENV GODOT_VERSION "4.3"
# Updates and installs to the server
RUN apk update
RUN apk add --no-cache bash
RUN apk add --no-cache wget
RUN apk add --no-cache git

# Allow this to run Godot
RUN wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-2.35-r1.apk
RUN apk add --allow-untrusted glibc-2.35-r1.apk

# Download Godot and export template, version is set from variables
RUN wget https://downloads.tuxfamily.org/godotengine/4.3/Godot_v4.3-stable_linux.x86_64.zip \
    && mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && unzip Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip \
    && mv Godot_v${GODOT_VERSION}-stable_linux.x86_64 /usr/local/bin/godot \
    && rm -f Godot_v${GODOT_VERSION}-stable_linux.x86_64.zip

RUN mkdir /godotapp
WORKDIR /godotapp
RUN wget ${RELEASE_DOWNLOAD} \
    && unzip Linux.zip
CMD godot --main-pack *.pck

EXPOSE 9009