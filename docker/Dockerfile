FROM ubuntu:22.04
RUN apt update && apt install -y locales && locale-gen en_US en_US.UTF-8 && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8
RUN apt install -y software-properties-common
RUN apt-add-repository universe
RUN apt update && apt install curl -y && curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
    -o /usr/share/keyrings/ros-archive-keyring.gpg && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] \
    http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
ENV DEBIAN_FRONTEND=NONINTERACTIVE
RUN apt update && apt upgrade -y && apt install -y ros-iron-ros-base python3-argcomplete && apt install -y ros-dev-tools
RUN apt update && apt install -y ros-iron-realsense2-camera ros-iron-apriltag
RUN apt update && apt install -y ros-iron-apriltag-ros
RUN mkdir -p /workspaces
COPY scripts/entrypoint.sh /workspaces/entrypoint.sh
RUN chmod +x /workspaces/entrypoint.sh
ENTRYPOINT [ "/workspaces/entrypoint.sh" ]