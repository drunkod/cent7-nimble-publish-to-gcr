#FROM centos:7
# Use the latest CoreOS 7 base image
FROM quay.io/coreos/base:latest

#MAINTAINER Your Name <your.email@example.com>

# Update packages and install any needed utilities
RUN yum update -y && \
    yum install -y vim wget curl

# Add Nimble Streamer repository
RUN bash -c 'echo -e "[nimble]\nname= Nimble Streamer repository\nbaseurl=http://nimblestreamer.com/centos/7/\$basearch\nenabled=1\ngpgcheck=1\ngpgkey=http://nimblestreamer.com/gpg.key\n" > /etc/yum.repos.d/nimble.repo'

# Refresh package metadata
RUN yum makecache

# Install Nimble Streamer and SRT plugin
RUN yum install -y nimble nimble-srt-1.5

# Copy your application files to the container
#COPY <path-to-your-application> /<destination-folder-in-container>

# Set working directory
WORKDIR /home/${USERNAME}

EXPOSE 8081 1935

LABEL org.opencontainers.image.source="https://github.com/drunkod/cent7-nimble-publish-to-gcr"

# Start a Bash shell
CMD ["/bin/bash"]
