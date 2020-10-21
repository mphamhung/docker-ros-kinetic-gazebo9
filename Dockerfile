FROM ros:kinetic-ros-base

# install bootstrap tools
RUN apt-get update \
    && apt-get install wget curl \
    && sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' \
    && wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add - \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
    ros-kinetic-gazebo9-ros-pkgs ros-kinetic-gazebo9-ros-control ros-kinetic-gazebo9* \
    && rm -rf /var/lib/apt/lists/*
    
# RUN apt-get update && apt-get install -y mesa-utils && apt-get install -y binutils

#Get rid of some error when running gazebo
RUN apt-get update && apt-get install -y dbus && dbus-uuidgen > /var/lib/dbus/machine-id 

