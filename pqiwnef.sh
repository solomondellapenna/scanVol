#!/usr/bin/env bash
export KUBECONFIG=~/Downloads/dev-kubeconfig_yaml.yaml
rawaws=$(aws ec2 describe-volumes | egrep -o 'vol-\w+')
rawkube=$(kubectl describe pv | egrep -o 'vol-\w+')

[[ $rawaws in $rawkube ]]
echo "${BASH_REMATCH[1]}"

# echo $rawaws
# echo $rawkube