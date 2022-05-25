FROM ubuntu:20.04
RUN apt-get update \ 
    && dpkg --add-architecture i386 \
    && apt-get install -y gcc-multilib make nasm \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY . .
RUN make assembly-sort
ENTRYPOINT [ "./assembly-sort" ]
