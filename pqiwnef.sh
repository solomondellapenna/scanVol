#!/usr/bin/env bash
rawaws=$(aws ec2 describe-volumes | grep VolumeId)
listaws=$(awk '/vol-\w+\d+\w+/ $rawaws }')
echo $listaws