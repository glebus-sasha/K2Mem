FROM ubuntu:22.04

# -----------------------------------------------------------------------------
# 1. System dependencies
# -----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    g++ \
    gcc \
    make \
    bash \
    wget \
    curl \
    unzip \
    rsync \
    perl \
    jq \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

# -----------------------------------------------------------------------------
# 2. Install Kraken2
# -----------------------------------------------------------------------------
RUN git clone https://github.com/DerrickWood/kraken2.git && \
    cd kraken2 && \
    ./install_kraken2.sh /opt/kraken2

ENV PATH="/opt/kraken2:${PATH}"

# -----------------------------------------------------------------------------
# 3. Install K2Mem
# -----------------------------------------------------------------------------
RUN git clone https://github.com/davide92/K2Mem.git && \
    cd K2Mem && \
    mkdir /opt/k2mem-bin && \
    bash install_k2mem.sh /opt/k2mem-bin

ENV PATH="/opt/k2mem-bin:${PATH}"

CMD ["bash"]
