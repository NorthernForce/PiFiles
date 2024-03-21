FROM ubuntu:22.04
RUN apt update && apt install -y locales && locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
RUN apt install -y software-properties-common
RUN apt-add-repository universe
ARG ROS_DISTRO=iron
RUN apt update && apt install curl -y && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    -o /usr/share/keyrings/ros-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
    http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
ENV DEBIAN_FRONTEND=NONINTERACTIVE
RUN apt update && apt upgrade -y && apt install -y ros-${ROS_DISTRO}-ros-base python3-argcomplete && apt update && apt install -y ros-dev-tools
RUN apt update && apt install -y ros-${ROS_DISTRO}-apriltag
RUN apt update && apt install -y ros-${ROS_DISTRO}-apriltag-ros
RUN apt update && apt install -y ros-${ROS_DISTRO}-image-proc
RUN apt update && apt install -y ros-${ROS_DISTRO}-navigation2
RUN apt update && apt install -y python3 python3-pip libssh-dev libprotobuf-dev
RUN apt update && apt install -y generate-ninja ninja-build protobuf*
RUN pip3 install jinja2
WORKDIR /tmp
RUN git clone https://github.com/wpilibsuite/allwpilib.git -b v2024.2.1
RUN cd allwpilib && mkdir build && cd build && cmake .. -DWITH_JAVA=OFF -DWITH_WPILIB=OFF -DWITH_EXAMPLES=OFF \
    -DWITH_TESTS=OFF -DWITH_GUI=OFF -DWITH_SIMULATION_MODULES=OFF -DWITH_JAVA_SOURCE=OFF
RUN cd allwpilib/build && make -j4
RUN cd allwpilib/build && make install
RUN rm -rf allwpilib
RUN apt update && apt install -y nlohmann-json3-dev
RUN apt update && apt install -y ros-${ROS_DISTRO}-usb-cam ros-${ROS_DISTRO}-v4l2-camera
RUN apt update && apt install -y ros-${ROS_DISTRO}-fuse*
RUN ln -s /opt/ros/${ROS_DISTRO}/lib/$(uname -m)-linux-gnu/liburdfdom_model.so.4.0 /opt/ros/${ROS_DISTRO}/lib/liburdfdom_model.so.4.0
RUN ldconfig
RUN mkdir -p /workspaces
COPY scripts/entrypoint.sh /workspaces/entrypoint.sh
RUN chmod +x /workspaces/entrypoint.sh
ENTRYPOINT [ "/workspaces/entrypoint.sh" ]
