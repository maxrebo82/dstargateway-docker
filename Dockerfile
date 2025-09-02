# Use a slim Debian image as the base
FROM debian:bullseye-slim

# Set a working directory for the build process
WORKDIR /usr/src/app

# Update package lists and install dependencies
# - build-essential: For compiling the C++ code (make, g++, etc.)
# - git: To clone the source code repository
# - ca-certificates: For git to verify SSL certificates
# - libcurl4-openssl-dev, libboost-dev: Libraries required by DStarGateway
# - bind9-host: For DNS utilities like 'host'
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    ca-certificates \
    libcurl4-openssl-dev \
    libboost-dev \
    bind9-host \
    && rm -rf /var/lib/apt/lists/*

# Clone the DStarGateway source code from the GitHub repository
RUN git clone https://github.com/F4FXL/DStarGateway.git .

# Execute the build and installation process as requested
# This sequence checks out the latest tagged release, then switches to the
# 'develop' branch before compiling and installing.
# 'make install' places the binary in /usr/local/bin/
# 'make newhostfiles' creates default configuration files in /etc/dstar-gateway/
RUN git config --global --add safe.directory /usr/src/app && \
    git pull -p && \
    git fetch --tags && \
    latestTag=$(git describe --tags `git rev-list --tags --max-count=1`) && \
    git checkout $latestTag && \
    git checkout develop && \
    # Patch Makefiles to remove systemd dependencies (systemctl calls) which fail in Docker
    find . -name 'Makefile' -type f -exec sed -i '/systemctl/d' {} + && \
    make && \
    make install newhostfiles

# Expose the UDP ports used by DStarGateway
EXPOSE 20000/udp
EXPOSE 20001/udp
EXPOSE 30001/udp
EXPOSE 30051/udp
EXPOSE 40000/udp

# The DStarGateway program runs in the foreground by default.
# The binary is installed at /usr/local/bin/DStarGateway
CMD ["/usr/local/bin/DStarGateway"]

