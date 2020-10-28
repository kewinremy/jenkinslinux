FROM jenkins/jenkins:lts

RUN curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin