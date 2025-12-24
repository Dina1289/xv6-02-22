# Dina Drilman 328300322 This Dockerfile creates an Ubuntu 16.04 image with the tools needed to build and run xv6,
# clones the xv6 repository, and starts a Bash shell.
FROM ubuntu:16.04

# add from local directory
# ADD ./xv6-11 /xv6-11
RUN apt-get -qq update && \
# --no-install-recommends reduces the Image size by almost 15%,
# but in our case git needs --reinstall ca-certificates to work 
    apt-get install -y --no-install-recommends --reinstall ca-certificates \
                    git \
# put dependencies here by the same way as git
                    make \
                    gcc-multilib \
                    qemu-system-x86 \
    &&git clone https://github.com/mit-pdos/xv6-public.git  xv6 \
    &&chmod +x xv6/*.pl \
#    &&chmod +x xv6-11/*.pl \
####
#    5 lines for general cleanning, -15% in size  
    &&apt-get purge -qq git \
    &&apt-get autoremove --purge -qq \
    &&apt-get clean -qq &&rm -rf /var/lib/apt/lists/* \
    &&rm -rf /tmp/* /var/tmp/* \
    &&rm -rf /usr/share/man/* /usr/share/doc/*

WORKDIR /xv6
#WORKDIR /xv6-11

CMD ["/bin/bash"]

