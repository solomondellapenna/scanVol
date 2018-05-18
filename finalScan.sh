#!/usr/bin/env bash
export KUBECONFIG=~/Downloads/dev-kubeconfig_yaml.yaml
rawAWS=$(aws ec2 describe-volumes | jq '.Volumes[] | .State, .VolumeId')
AWS="$(echo "$rawAWS" | fgrep -xv '"in-use"')"
final="$(echo "$AWS" | egrep -A 1 -o '"available"')"
rawKUBE=$(kubectl describe pv | egrep -o 'vol-\w+')
if [ -z "$final" ]
then 
    echo "All in use"
    exit 0
else  
    arr=($rawKUBE)
    ARR=()
    for i in "${arr[@]}"
    do
        ARR+="$(echo $final | egrep -o $i)"
    done
    if [ -z "$ARR" ]
    then
        delete="$(echo $final | egrep -o 'vol-\w+')"
        echo "'$delete' should be deleted"
        exit 1
    else 
        echo "Available volumes listed in Kubernetes"
        exit 0
    fi
fi
