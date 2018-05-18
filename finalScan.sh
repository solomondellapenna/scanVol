#!/usr/bin/env bash
export KUBECONFIG=~/Downloads/dev-kubeconfig_yaml.yaml
rawAWS=$(aws ec2 describe-volumes | jq '.Volumes[] | .State, .VolumeId')
AWS="$(echo "$rawAWS" | fgrep -xv '"in-use"')"
final="$(echo "$AWS" | egrep -A 1 -o '"available"')"
rawKUBE=$(kubectl describe pv | egrep -o 'vol-\w+')

# ARR=()
# for i in "${arr[@]}"
# do
#     ARR+=("$(echo "$i" | fgrep -exv '"vol-\w+"')")
# done
echo $final




#sed "/^in-use/d" $rawAWS
# echo $rawAWS
# AWS=$(echo $rawAWS | grep -o '"State".*')
# if [[ -z $AWS ]]
# then
#     echo "help"
# else
#     echo $AWS
# fi

#IF state exists and if does not equal in-use then print with 


#Parse out "in-use"
#If anything doesnt match vol- print the preceeding id