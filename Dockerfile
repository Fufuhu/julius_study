FROM debian:bullseye-slim AS builder

ARG JULIUS_VERSION=4.6

COPY v4.6.zip ./

RUN apt-get update && \
    apt-get install -y unzip build-essential
RUN unzip v${JULIUS_VERSION}.zip
WORKDIR /julius-${JULIUS_VERSION}
RUN ./configure && \
    make && \
    make install

FROM debian:bullseye-slim
COPY --from=builder /usr/lib/x86_64-linux-gnu/libgomp.so.1 /usr/lib/x86_64-linux-gnu
COPY --from=builder /usr/local/bin/ /usr/local/bin
COPY --from=builder /usr/local/lib/ /usr/local/lib
