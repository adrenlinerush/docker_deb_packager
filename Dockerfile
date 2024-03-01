FROM debian:bookworm

RUN apt-get update
RUN apt-get install -y build-essential git dh-make wget devscripts dpkg-dev

RUN cd /etc/apt/trusted.gpg.d/ && wget https://wiki.adrenlinerush.net/apt-repo/dists/stable/adrenlinerush-repo.gpg
RUN echo "deb https://wiki.adrenlinerush.net/apt-repo stable main" >> /etc/apt/sources.list
RUN apt-get update

CMD ["/bin/bash"]
