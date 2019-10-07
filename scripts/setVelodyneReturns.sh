#!/bin/bash

if (( $# != 1 ))
then
  echo "Usage: setVelodyneReturns type"
  echo "type - Strongest, Last, Dual"
  exit
fi

if [ "$1" == "Strongest" ] || [ "$1" == "Last" ] || [ "$1" == "Dual" ]
then
  curl --data "returns=$1" lidar/cgi/setting
  echo "Done"
else
  echo "Type must be Strongest, Last, or Dual"
fi
