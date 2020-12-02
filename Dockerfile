FROM ros:kinetic-ros-base

# install bootstrap tools
RUN apt-get update \
    && apt-get install wget curl \
    && sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' \
    && wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - \
    && apt-get update \
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
RUN pip install --upgrade pip && pip install --ignore-installed gym xacro lxml gitpython torch torchvision
RUN apt-get install -y ros-kinetic-pid ros-kinetic-xacro ros-kinetic-joy ros-kinetic-yocs-cmd-vel-mux ros-kinetic-robot-state-publisher
RUN echo "source devel/setup.bash" >> /root/.bash

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user
USER user