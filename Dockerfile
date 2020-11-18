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


