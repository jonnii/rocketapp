FROM debian:jessie

RUN apt-get update \
    && apt-get install -y curl file build-essential

RUN curl https://sh.rustup.rs -s > /home/install.sh && \
    chmod +x /home/install.sh && \
    sh /home/install.sh -y --verbose --default-toolchain nightly

ENV PATH "/root/.cargo/bin:$PATH"

EXPOSE 80

RUN mkdir -p /rust/app
WORKDIR /rust/app

ADD . /rust/app
RUN cargo build --release

ENV ROCKET_ENV "staging"

CMD cargo run --release