#!/usr/bin/env bash
export KUBECONFIG=~/Downloads/dev-kubeconfig_yaml.yaml
AWS=$(aws ec2 describe-volumes | jq -r '.Volumes[] | { id: .VolumeId, state: .State } | @text')
AVAILABLE="$(echo "$AWS" | grep -v '"in-use"')"
AVAIL_ID="$(echo "$AVAILABLE" | jq '.id')"
KUBE=$(kubectl describe pv | grep -E -o 'vol-\w+')
if [ -z "$AVAIL_ID" ]
then 
    #No "Available" volumes, all in use
    echo "All in use"
    exit 0
else  
    arr=($KUBE)
    ARR=()
    for i in "$arr"
    do
        ARR+="$(echo $AVAIL_ID | egrep -o $i)"
    done
    if [ -z "$ARR" ]
    then
        #"Available" volume found and not referenced in kubernetes pv
        delete="$(echo $AVAIL_ID | egrep -o 'vol-\w+' | tr '\n' ' ')"
        echo "$delete should be deleted"
        exit 1
    else 
        #"Available" volume found but referenced in kubernetes pv
        echo "Available volumes listed in Kubernetes"
        exit 0
    fi
fi