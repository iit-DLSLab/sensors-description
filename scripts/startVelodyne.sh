#!/bin/bash
echo "Setting Velodyne Lidar Settings"
if ping -c1 -w1 lidar > /dev/null 2>&1
then 
  echo "Found Lidar"
  curl --data "laser=Off&rpm=0&returns=Strongest" lidar/cgi/setting;
else
  echo "Could not find Lidar"
fi
echo "Done"

