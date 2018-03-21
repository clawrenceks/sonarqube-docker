FROM openjdk:8u161-windowsservercore-1709

ENV sonarqube_download_url "https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-6.5.zip"

ENV sonar_jdbc_url "!"
ENV sonar_jdbc_username "!"
ENV sonar_jdbc_password "!"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

VOLUME C:\\SonarQube\\extensions\\plugins

EXPOSE 9000

COPY Start.ps1 /

RUN Invoke-WebRequest $env:sonarqube_download_url -OutFile '/SonarQube.zip' -UseBasicParsing ; \
    Expand-Archive -Path '/SonarQube.zip' -Destination '/SonarQubeTemp' ; \
    Move-Item -Path '/SonarQubeTemp/*' -Destination '/SonarQube' ; \
    Copy-Item -Path C:\SonarQube\sonarqube-6.5\* -Destination C:\sonarqube\ -Exclude .\sonarqube-6.5\extensions\plugins\* -Recurse -Force ; \
    Remove-Item '/SonarQube/sonarqube-6.5'  -Force -Recurse ; \
    Remove-Item -Force -Recurse '/SonarQubeTemp' ; \
    Remove-Item -Force '/SonarQube.zip' ;

CMD .\Start.ps1 -sonar_jdbc_url $env:sonar_jdbc_url -sonar_jdbc_username $env:sonar_jdbc_username -sonar_jdbc_password $env:sonar_jdbc_password -Verbose