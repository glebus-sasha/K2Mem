FROM ubuntu:22.04

# -----------------------------------------------------------------------------
# 1. Install build dependencies
# -----------------------------------------------------------------------------
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    g++ \
    make \
    bash \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------------------------------------------------------
# 2. Clone K2Mem
# -----------------------------------------------------------------------------
WORKDIR /opt
RUN git clone https://github.com/davide92/K2Mem.git

WORKDIR /opt/K2Mem

# -----------------------------------------------------------------------------
# 3. Compile and install K2Mem
#    install_k2mem.sh requires a destination directory
# -----------------------------------------------------------------------------
RUN mkdir /opt/k2mem-bin && \
    bash install_k2mem.sh /opt/k2mem-bin

# -----------------------------------------------------------------------------
# 4. Symlink binaries into PATH
# -----------------------------------------------------------------------------
RUN ln -s /opt/k2mem-bin/k2mem /usr/local/bin/k2mem && \
    ln -s /opt/k2mem-bin/k2mem-build /usr/local/bin/k2mem-build && \
    ln -s /opt/k2mem-bin/k2mem-inspect /usr/local/bin/k2mem-inspect

# -----------------------------------------------------------------------------
# 5. Default command
# -----------------------------------------------------------------------------
CMD ["bash"]
