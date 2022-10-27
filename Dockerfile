# OAK-D Pro W
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
        wget \
        build-essential \
        cmake \
        python3-pip \
        python3-numpy \
        python3-dev \
        pkg-config \
        libjpeg-dev \
        libtiff5-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libv4l-dev \
        libxvidcore-dev \
        libx264-dev \
        libgtk2.0-dev \
        libgtk-3-dev \
        libatlas-base-dev \
        gfortran \
        git \
        nano \
        sudo \
        udev \
        patchelf \
        libusb-1.0-0-dev \
        libusb-1.0-doc \
        libxcb-xinerama0 \
        libxkbcommon-x11-0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxcb-keysyms1 \
        libxcb-render-util0 \
        libxcb-xinerama0 \
        libgtk2.0-dev \
        xvfb \
        usbutils \
        curl \
        lsb-release \
        libtbb2 \
        libtbb-dev \
        libpng-dev \
        libtiff-dev \
        ffmpeg \
        libsm6 \
        libxext6 \
        libgl1-mesa-glx \
        python3-pyqt5 \
        python3-pyqt5.qtquick \
        qml-module-qtquick-controls2 \
        qml-module-qt-labs-platform \
        qtdeclarative5-dev \
        qml-module-qtquick2 \
        qtbase5-dev \
        qtchooser \
        qt5-qmake \
        qtbase5-dev-tools \
        qml-module-qtquick-layouts \
        qml-module-qtquick-window2 \
    && sed -i 's/# set linenumbers/set linenumbers/g' /etc/nanorc \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -U pip \
    && pip install opencv-contrib-python==4.5.1.48 \
    && pip install depthai==2.17.4.0 \
    && pip install blobconverter==1.3.0 \
    && pip install sentry_sdk==1.10.1

# Create a user who can sudo in the Docker container
ENV USERNAME=user
RUN echo "root:root" | chpasswd \
    && adduser --disabled-password --gecos "" "${USERNAME}" \
    && echo "${USERNAME}:${USERNAME}" | chpasswd \
    && echo "%${USERNAME}    ALL=(ALL)   NOPASSWD:    ALL" >> \
        /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}
USER ${USERNAME}

RUN echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="03e7", MODE="0777"' | \
    sudo tee /etc/udev/rules.d/80-movidius.rules

RUN echo "sudo chown -R ${USERNAME} /etc/udev/rules.d" >> ${HOME}/.bashrc \
    && echo 'sudo /lib/systemd/systemd-udevd --daemon' >> ${HOME}/.bashrc \
    && echo 'sudo udevadm control --reload-rules'  >> ${HOME}/.bashrc \
    && echo 'sudo udevadm trigger'  >> ${HOME}/.bashrc \
    && echo "sudo chown -R ${USERNAME} /dev/bus" >> ${HOME}/.bashrc \
    && echo "sudo chmod -R 0777 /dev/bus" >> ${HOME}/.bashrc
