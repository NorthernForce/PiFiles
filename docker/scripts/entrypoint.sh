#!/bin/bash
source /opt/ros/rolling/setup.bash
echo "source /opt/ros/rolling/setup.bash" > ~/.bash_profile
if [ -f install/setup.bash ] ; then
    source install/setup.bash
fi
$@