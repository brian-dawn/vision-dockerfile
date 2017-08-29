from ubuntu:16.04

# Opencv
RUN \ 
    apt-get update && apt-get upgrade -y && \
    apt-get install --assume-yes wget unzip && \


    apt-get install --assume-yes build-essential cmake git && \
    apt-get install --assume-yes pkg-config unzip ffmpeg qtbase5-dev python-dev python3-dev python-numpy python3-numpy && \
    apt-get install --assume-yes libopencv-dev libgtk-3-dev libdc1394-22 libdc1394-22-dev libjpeg-dev libpng12-dev libtiff5-dev libjasper-dev && \
    apt-get install --assume-yes libavcodec-dev libavformat-dev libswscale-dev libxine2-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev && \
    apt-get install --assume-yes libv4l-dev libtbb-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev && \
    apt-get install --assume-yes libvorbis-dev libxvidcore-dev v4l-utils python-vtk && \
    apt-get install --assume-yes liblapacke-dev libopenblas-dev checkinstall && \
    apt-get install --assume-yes libgdal-dev && \

    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \

    wget https://github.com/opencv/opencv/archive/3.2.0.zip && \
    unzip 3.2.0.zip && \
    cd opencv-3.2.0 && \
    mkdir build && \
    cd build && \

    cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D INSTALL_C_EXAMPLES=OFF \
    -D BUILD_EXAMPLES=OFF .. && \

    make -j && \
    make install

# Realsense
RUN \
    # upgrade/dist-upgrade not recommended maybe get rid of
 
    #apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y && \
    apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --install-recommends linux-generic-lts-xenial xserver-xorg-core-lts-xenial xserver-xorg-lts-xenial xserver-xorg-video-all-lts-xenial xserver-xorg-input-all-lts-xenial libwayland-egl1-mesa-lts-xenial && \
    apt-get install -y libusb-1.0-0-dev pkg-config && \
    
    git clone https://github.com/IntelRealSense/librealsense.git && \
    cd librealsense && \
    mkdir build && \
    cd build && \
    cmake ../ -DBUILD_EXAMPLES=false -DBUILD_GRAPHICAL_EXAMPLES=false && \
    make && \
    make install

RUN apt-get install -y libboost-dev

# Serial library.
RUN \
    apt-get install -y catkin && \
    git clone https://github.com/wjwwood/serial.git && \
    cd serial && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make && \
    make install

# libnmea
RUN \
    git clone https://github.com/jacketizer/libnmea.git && \
    cd libnmea && \
    make && \
    make install

# specific boost libs
RUN \
    apt-get install -y libboost-filesystem-dev libboost-thread-dev

# PCL
RUN \
    apt-get install -y libpcl-dev

RUN \
    apt-get install -y libglfw3-dev

