FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu18.04
LABEL maintainer="Damian Barsotti<damian@famaf.unc.edu.ar>"

RUN DEBIAN_FRONTEND=noninteractive dpkg --add-architecture i386

#Installs dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo \
        glmark2 \
        mesa-utils \
        mc \
        locales

RUN locale-gen en_US.UTF-8 && update-locale

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
        libstdc++6:i386\
        libgl1-mesa-glx:i386\
        libgpg-error0:i386\
        libfreetype6:i386\
        libfontconfig1:i386\
        libgtk2.0-0:i386\
        libnss3:i386\
        libasound2:i386\
        libasound2-plugins:i386

COPY libgcrypt11_1.5.3-2ubuntu4.5_i386.deb /
COPY libpng12-0_1.2.54-1ubuntu1_i386.deb /

RUN DEBIAN_FRONTEND=noninteractive dpkg -i libgcrypt11_1.5.3-2ubuntu4.5_i386.deb
RUN DEBIAN_FRONTEND=noninteractive dpkg -i libpng12-0_1.2.54-1ubuntu1_i386.deb

RUN rm -f libgcrypt11_1.5.3-2ubuntu4.5_i386.deb\
    libpng12-0_1.2.54-1ubuntu1_i386.deb

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/games/Portal


#Creates unprivileged user.
COPY /create-user.sh /
RUN chmod +x create-user.sh
ARG docker_root_pass=angela
ARG docker_unprivileged_user=gamer
ARG docker_unprivileged_pass=george
RUN /create-user.sh && \
    rm /create-user.sh

USER $docker_unprivileged_user
WORKDIR /home/$docker_unprivileged_user
