# versiion
ARG cuda_version=10.1
# ARG cudnn_version=7
ARG ubuntu_version=16.04
# ARG nvidia_cudnn_version=7.1.3.16-1+cuda9.0

FROM nvidia/cudagl:${cuda_version}-devel-ubuntu${ubuntu_version}


RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list
# Add the package keys.
RUN apt-key adv --keyserver 'hkp://ha.pool.sks-keyservers.net:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

# Install 'ros-kinetic-desktop-full' packages (including ROS, Rqt, Rviz, and more).
#ARG ros_desktop_version
#ENV ROS_DESKTOP_VERSION=${ros_desktop_version}
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-kinetic-ros-base \
    && rm -rf /var/lib/apt/lists/*

# install bootstrap tools
RUN apt-get update -y\
    && apt-get install wget curl -y \
    && sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' \
    && wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - \
    && apt-get update -y\
    && apt-get install --no-install-recommends -y \
    ros-kinetic-gazebo9-ros-pkgs ros-kinetic-gazebo9-ros-control ros-kinetic-gazebo9* ros-kinetic-rviz \
    libqt4-dev \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

#Get rid of some error when running gazebo
RUN apt-get update && apt-get install -y dbus && dbus-uuidgen > /var/lib/dbus/machine-id

RUN apt-get install -y python-pip && pip install catkin-tools

WORKDIR /sim_ws/

## open_ai dependencies
RUN pip install --upgrade "pip < 21.0" && pip install --ignore-installed gym xacro lxml gitpython torch torchvision
RUN apt-get install -y ros-kinetic-pid ros-kinetic-xacro ros-kinetic-joy ros-kinetic-yocs-cmd-vel-mux ros-kinetic-robot-state-publisher
RUN apt-get install git -y
RUN pip install --upgrade --ignore-installed pyasn1-modules
RUN pip install jupyter tensorboard
RUN echo "source devel/setup.bash" >> /root/.bash

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
USER user
