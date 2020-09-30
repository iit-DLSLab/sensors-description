#!/bin/bash

if (( $# != 1 ))
then
  echo "Usage: setVelodyneLaser status"
  echo "status - On, Off"
  exit
fi

if [ "$1" == "On" ] || [ "$1" == "Off" ]
then
  curl --data "laser=$1" lidar/cgi/setting
  echo "Done"
else
  echo "Status must be On or Off"
fi
