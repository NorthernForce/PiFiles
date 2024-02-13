FROM ubuntu:22.04
RUN apt update && apt install -y locales && locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
RUN apt install -y software-properties-common
RUN apt-add-repository universe
RUN apt update && apt install curl -y && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    -o /usr/share/keyrings/ros-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
    http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
ENV DEBIAN_FRONTEND=NONINTERACTIVE
RUN apt update && apt upgrade -y && apt install -y ros-iron-ros-base python3-argcomplete && apt update && apt install -y ros-dev-tools
WORKDIR /opt/realsense
RUN git clone https://github.com/IntelRealSense/librealsense -b v2.54.1
RUN apt update && apt install git cmake libssl-dev freeglut3-dev libusb-1.0-0-dev pkg-config libgtk-3-dev unzip -y
RUN cd librealsense && mkdir build && cd build && cmake .. -DFORCE_RSUSB_BACKEND=true -DCMAKE_BUILD_TYPE=release
RUN cd librealsense/build && make -j6
RUN cd librealsense/build && make install
WORKdir /opt/ros/realsense
RUN mkdir -p src && cd src && git clone https://github.com/IntelRealSense/realsense-ros -b 4.54.1
RUN . /opt/ros/iron/setup.sh && rosdep init && rosdep update && rosdep install --ignore-src --from-paths src -y --skip-keys librealsense2
RUN . /opt/ros/iron/setup.sh && colcon build --merge-install --install-base /opt/ros/iron
RUN rm -rf src build log
RUN apt update && apt install -y ros-iron-apriltag
RUN apt update && apt install -y ros-iron-apriltag-ros
RUN apt update && apt install -y ros-iron-image-proc
RUN apt update && apt install -y ros-iron-navigation2
RUN apt update && apt install -y python3 python3-pip libssh-dev libprotobuf-dev
RUN apt update && apt install -y generate-ninja ninja-build protobuf*
RUN pip3 install jinja2
WORKDIR /tmp
RUN git clone https://github.com/wpilibsuite/allwpilib.git -b v2024.2.1
RUN cd allwpilib && mkdir build && cd build && cmake .. -DWITH_JAVA=OFF -DWITH_WPILIB=OFF -DWITH_EXAMPLES=OFF \
    -DWITH_TESTS=OFF -DWITH_GUI=OFF -DWITH_SIMULATION_MODULES=OFF -DWITH_JAVA_SOURCE=OFF
RUN cd allwpilib/build && make -j$(nproc)
RUN cd allwpilib/build && make install
RUN rm -rf allwpilib
RUN apt update && apt install -y nlohmann-json3-dev
RUN apt update && apt install -y ros-iron-usb-cam ros-iron-v4l2-camera
RUN apt update && apt install -y ros-iron-fuse*
RUN ln -s /opt/ros/iron/lib/$(uname -m)-linux-gnu/liburdfdom_model.so.3.0 /opt/ros/iron/lib/liburdfdom_model.so.3.0
RUN ldconfig
RUN mkdir -p /workspaces
COPY scripts/entrypoint.sh /workspaces/entrypoint.sh
RUN chmod +x /workspaces/entrypoint.sh
ENTRYPOINT [ "/workspaces/entrypoint.sh" ]
