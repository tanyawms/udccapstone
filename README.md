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
A nodejs application that consists of a couple of webpages is used for this assignment. The nodejs application also uses the Bootstrap library for common components. There are two versions of the application, one with a blue background and the other with a green background, making it easy to identify the deployments. The nodejs application is converted to a Docker image based on a Dockerfile. The Dockerfile is checked for errors (linted). The Dockerfile contents are explained below.

     FROM node:10-alpine - Pull the image from the Docker repository

     RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app - Make a directory and change ownership

     WORKDIR /home/node/app - Change to the main directory

     COPY package*.json ./ - Use a wildcard to copy both the package.json and the package-lock.json files

     USER node - Set the user

     RUN npm install - Install the app and dependencies

     COPY --chown=node:node . . - Copy the files and change ownership

     EXPOSE 3000 - Expose the port for the application

     CMD [ "node", "app.js" ] - Start the application


The command to execute the Dockerfile is:
docker build -f Dockerfile --tag=<filename> --label=<filename> .

However, a script is used to include a step to lint the file. The run_docker.sh script is shown below:

     #!/usr/bin/env bash

     ## Complete the following steps to get Docker running locally

     # Step 1:
     # Lint the Dockerfile
     # This is linter for Dockerfiles
     hadolint Dockerfile

     # Step 2:
     # Build image and add a descriptive tag
     docker build -f Dockerfile --tag=<filename> --label=<filename> .

     # Step 3:
     # List docker images
     docker image ls --filter label=<filename> 

Hadolint is used to check the Dockerfile for errors. If an error is found, the output is like:


The output of a file without errors is like:


After the Docker image is built, another script (upload_docker.sh) is used to upload the image to Dockerhub.

The above procedures are executed twice, once for the blue application and again for the green application.





STEP THREE: BUILD A KUBERNETES CLUSTER



STEP FOUR: BLUE/GREEN DEPLOYMENTS