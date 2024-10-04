FROM debian:stable
RUN useradd -ms /bin/sh user
RUN apt-get update
RUN apt-get install sudo curl libtinfo6 git xz-utils -y
RUN echo "user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER user
WORKDIR /home/user
ENV THEOS=/home/user/theos
RUN git clone --recursive https://github.com/theos/theos.git ${THEOS}
RUN curl -sL https://github.com/kabiroberai/swift-toolchain-linux/releases/download/v2.3.0/swift-5.8-ubuntu20.04.tar.xz | tar -xJvf - -C ${THEOS}/toolchain/
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/theos/theos/master/bin/install-theos)"
ENTRYPOINT ["bash"]