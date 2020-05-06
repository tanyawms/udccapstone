This capstone project uses NodeJS, Docker, Jenkins, AWS EKS, and shell scripts to create a blue/green deployment pipeline.

STEP ONE: BUILD A JENKINS INSTANCE

The Jenkins instance is built from an AWS CloudFormation template. The template file is located at buildjenkins/buildjenkins.yaml. The template includes network components (VPC, Subnet, Internet Gateway, Elastic IP, Route Table), IAM components (Role, Security Group), and EC2 instance information (instance type, image id, volume size and type). The UserData section is used to add Jenkins as well as other packages to the EC2 instance. The packages include (java, jq, zip, hadolint, AWS CLI, eksctl, kubectl)

The command to run the template is:
aws cloudformation create-stack --stack-name <stackname> --template-body file:buildjenkins.yaml --capabilities CAPABILITY_NAMED_IAM

After the ec2 instance is built, the IP address can be obtained from the console. The link for the Jenkins instance is:
http://<IP ADDRESS>:8080

On first login a screen appears with the location of the Jenkins admin password. Use SSH to login to the server from a terminal window. The password can be obtained by using more,less, or cat to list the file contents. For example:
sudo more /var/lib/jenkins/secrets/initialAdminPassword
a620dl28eff14892b1ad9dc2b3ceaab2

Use the password to login and create a separate admin account with a separate username and password.

Next install the suggested plugins. After Jenkins restarts, login with the username and password created in a previous step.

Select Manage Jenkins -->Manage Plugins to add plugins. Click the Available tab and use the Filter field to search for and install the plugins listed below.

 The Jenkins plugins used are: 
    Green Balls - Successful builds appear as green balls instead of the default blue.
    Blue Ocean - A set of plugins to simplify Jenkins pipelines
    CloudBees AWS Credentials Plugin - Connects Jenkins with AWS credentials
    CloudBees Docker Build and Publish plugin - Connects Jenkins with Docker/Dockerhub
    Github - Connects Jenkins with Github
    Pipeline - A suite of plugins to help build and automate pipelines
    Pipeline: AWS Steps - Integrates Jenkins pipelines with AWS
    SSH Credentials - Allows Jenkins to be accessed via ssh


STEP TWO: DOCKERIZE AN APPLICATION




STEP THREE: BUILD A KUBERNETES CLUSTER



STEP FOUR: BLUE/GREEN DEPLOYMENTS