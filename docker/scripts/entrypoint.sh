#!/bin/bash
source /opt/ros/iron/setup.bash
echo "source /opt/ros/iron/setup.bash" > ~/.bash_profile
if [ -f install/setup.bash ] ; then
    source install/setup.bash
fi
$@