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
RUN apt update && apt install -y ros-iron-realsense2-camera ros-iron-apriltag
RUN apt update && apt install -y ros-iron-apriltag-ros
RUN apt update && apt install -y ros-iron-image-proc
RUN apt update && apt install -y ros-iron-navigation2
RUN apt update && apt install -y python3 python3-pip libssh-dev libprotobuf-dev
RUN apt update && apt install -y generate-ninja ninja-build
RUN pip3 install jinja2
WORKDIR /tmp
RUN git clone https://github.com/wpilibsuite/allwpilib.git -b v2024.1.1-beta-1
RUN cd allwpilib && mkdir build && cd build && cmake .. -DWITH_JAVA=OFF -DWITH_WPILIB=OFF -DWITH_EXAMPLES=OFF \
    -DWITH_TESTS=OFF -DWITH_GUI=OFF -DWITH_SIMULATION_MODULES=OFF -DWITH_JAVA_SOURCE=OFF
RUN cd allwpilib/build && make -j$(nproc)
RUN cd allwpilib/build && make install
RUN rm -rf allwpilib
RUN apt update && apt install -y nlohmann-json3-dev
RUN apt update && apt install -y ros-iron-usb-cam ros-iron-v4l2-camera
RUN ldconfig
RUN mkdir -p /workspaces
COPY scripts/entrypoint.sh /workspaces/entrypoint.sh
RUN chmod +x /workspaces/entrypoint.sh
ENTRYPOINT [ "/workspaces/entrypoint.sh" ]
