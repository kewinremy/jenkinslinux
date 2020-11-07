# Continous Integration with Jenkins Pipelines for .NET Core Applications (Part 1)

## Installing Jenkins Master on Linux containers (OS: Debian 9)

1. Step 1: Jenkins Installation

Create a dockerfile and select the official docker image from 
jenkins on dockerhub : https://hub.docker.com/r/jenkins/jenkins.

```
FROM jenkins/jenkins:lts

```
2. Step 2: Update the jenkinsfile
            
If you want a fully automatic installation, please update your dockerfile as defined below and create a copy the dotnetInstall.sh in a scripts directory.

```
FROM jenkins/jenkins:lts

# Setting the User
USER root

# Setting bash as the default shell
SHELL ["/bin/bash", "-c"]

# Installing .NET Core SDK and Runtime
COPY scripts  /var/tmp/scripts
RUN /var/tmp/scripts/dotnetInstall.sh

# Testing cli is installed
RUN dotnet --version

```
3. Step 3: .NET Core on debian

create a scripts directory in your build directory and the following content to dotnetInstall.sh

```
# Source: https://docs.microsoft.com/en-us/dotnet/core/install/linux-debian#debian-9-

# Installing sudo on debian
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install sudo

# packages
wget -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
wget https://packages.microsoft.com/config/debian/9/prod.list
sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list

# sdk
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-3.1

# runtime
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-3.1
```


4. Step 4: Building your docker image

Finally, you can rebuild a second image and run it with the following commands:

```
docker build -t jenkinslinux:1.0.0 .
```

5. Step 5: Run your image and start a container

```
docker run -p 8080:8080 -p 50000:50000 jenkinslinux:1.0.0
```

6. Step 6: Start using Jenkins

Browse http://localhost:8080 and Jenkins Web Ui will start. 

In /var/jenkins_home/secrets/initialAdminPassword you will find the initial password.

You can open see it in your console with cat /var/jenkins_home/secrets/initialAdminPassword