import re
import subprocess, os
# a = str(subprocess.check_output(["aws ec2 describe-volumes | grep VolumeId"], shell=True))
b = str(subprocess.check_output(["kubectl describe pv | grep VolumeID"], shell=True, env=))
# y = re.findall("vol-\w+\d+\w+", a)
# z = re.findall("vol-\w+\d+\w+", b)
subprocess.Popen("ls", env=)    

my_env = os.environ.copy()
my_env["KUBECONFIG"] = "~/Downloads/dev-kubeconfig.yaml"
subprocess.Popen(my_command, env=my_env)