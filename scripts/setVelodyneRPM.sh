#!/bin/bash

if (( $# != 1 ))
then
  echo "Usage: setVelodyneRPM rpm"
  echo "rpm - Lidar RPM from 0 to 1200"
  exit
fi


if (( $1 < 0 )) || (( $1 > 1200 ))
then
  echo "RPM must be between 0 and 1200"
else
  curl --data "rpm=$1" lidar/cgi/setting
  echo "Done"
fi
