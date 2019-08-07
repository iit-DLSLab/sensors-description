#!/bin/bash

if (( $# != 2 ))
then
  echo "Usage: setVelodyneFOV start end"
  echo "start and end must be: 0<=start<end<=359"
  exit
fi


if (( $1 < 0 )) || (( $1 >= $2 )) || (( $2 > 359 ))
then
  echo "start and end must be: 0<=start<end<=359"
else
  curl --data "start=$1&end=$2" lidar/cgi/setting/fov
  echo "Done"
fi
