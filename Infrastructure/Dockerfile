FROM jenkins/jenkins:lts

# Setting the User
USER root

# Setting bash as the default shell
SHELL ["/bin/bash", "-c"]

# Installing sudo on debian
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install sudo

# Installing .NET Core SDK and Runtime
COPY scripts  /var/tmp/scripts
RUN /var/tmp/scripts/dotnetInstall.sh

# Testing cli is installed
RUN dotnet --version