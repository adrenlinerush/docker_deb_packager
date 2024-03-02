FROM debian:bookworm

RUN echo "deb-src http://deb.debian.org/debian/ bookworm contrib main non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian/ bookworm-updates contrib main non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian/ bookworm-proposed-updates contrib main non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian/ bookworm-backports contrib main non-free non-free-firmware" >> /etc/apt/sources.list
RUN echo "deb-src http://deb.debian.org/debian-security/ bookworm-security contrib main non-free non-free-firmware" >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y build-essential git dh-make wget devscripts dpkg-dev quilt

COPY .quiltrc ~/.quiltrc

CMD ["/bin/bash"]
