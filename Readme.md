# Continous Integration with Jenkins Pipelines

## Installing Jenkins Master on Linux containers (OS: Debian 9)

### Jenkins Master

1. Jenkins Installation

Create a dockerfile and select the official docker image from 
jenkins on dockerhub : https://hub.docker.com/r/jenkins/jenkins.

```
FROM jenkins/jenkins:lts

```
2. build the container (jenkins master will be installed)
            
```
docker build -t jenkinslinux:1.0

```

3. NET Core Installation

In order to build .net projects (console apps, asp.net projects), you will 
need to load .NET Core Runtime + .NET Core SDK. Because dotnet-install.sh do not work on this image (source: https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script, curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin), you will need to perform the installation yourself according to the two ways described below. 


4. Installation with the dockerfile (recommended): 



5. Manually in the container (not recommended):

Run bash commands as a root user (administrator in windows)

```
docker exec -it -u root bc155 bash 

```

Install sudo command on debian (because it is not installed by default)

```
apt update
apt upgrade
apt install sudo
```

Install .Net Core Runtime and .Net Core SDK

First, check the version of debian. Installation can only be done with versions 9, 10 of Debian. 
For more information: https://docs.microsoft.com/en-us/dotnet/core/install/linux-debian

```
cat /etc/os-release

```

Because the container has debian 9, please complete the following 3 steps: 

Get the packages
```
wget -O - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/
wget https://packages.microsoft.com/config/debian/9/prod.list
sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list
sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg
sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list
```

Install .NET Core SDK
```
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-3.1
```

Install .NET Core Runtime
```
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-3.1
```

Check everything works and .NET Core CLI is installed:

```
dotnet --version
```






