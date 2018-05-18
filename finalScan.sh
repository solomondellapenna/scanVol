rawAWS=$(aws ec2 describe-volumes | jq '.Volumes[] | .State, .VolumeId')
#egrep -o -A 2 --group-separator=$'\n' '"SnapshotId".*')

echo $rawAWS
# AWS=$(echo $rawAWS | grep -o '"State".*')
# if [[ -z $AWS ]]
# then
#     echo "help"
# else
#     echo $AWS
# fi

#IF state exists and if does not equal in-use then print with 