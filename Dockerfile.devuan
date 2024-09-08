FROM devuan/devuan

RUN apt-get update
RUN apt-get install -y build-essential git dh-make wget devscripts dpkg-dev quilt

COPY .quiltrc ~/.quiltrc

CMD ["/bin/bash"]
