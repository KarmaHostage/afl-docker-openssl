FROM debian:jessie
MAINTAINER Quinten De Swaef
RUN apt-get update && apt-get install build-essential wget -y
RUN wget 'http://lcamtuf.coredump.cx/afl/releases/afl-2.10b.tgz' -O- | tar zxvf -  && cd afl-* && make PREFIX=/usr install && cd /
RUN wget 'https://github.com/openssl/openssl/archive/OpenSSL_1_1_0-pre5.tar.gz' -O- | tar zxvf -  && cd openssl-* && CC=/usr/bin/afl-gcc ./Configure linux-x86_64 no-shared  && make clean all install && cd /
ADD initialize.sh /initialize.sh
RUN mkdir -p /examples
COPY examples/* /examples/
RUN chmod +x /initialize.sh
VOLUME /fuzzing
ENTRYPOINT ["./initialize.sh"]
