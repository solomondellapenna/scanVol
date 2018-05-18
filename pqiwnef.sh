#!/usr/bin/env bash
export KUBECONFIG=~/Downloads/dev-kubeconfig_yaml.yaml
rawAWS=$(aws ec2 describe-volumes | egrep -o 'vol-\w+')
rawKUBE=$(kubectl describe pv | egrep -o 'vol-\w+')
arr=($rawKUBE)
for i in "${arr[@]}"
do
    x="$(echo $rawAWS | egrep -o $i)"
    if [ -z "$x" ] ; then
        echo 1
    else
        echo 2
    fi
done

# do
#     x="$(echo $rawKUBE | egrep -o $i | head -1)"
# done




# if [ -z "$x" ]
# then
#     exit 0
# else 
#     echo $x "should be deleted"
#     exit 1
# fi
