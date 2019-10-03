FROM openjdk:8u222-windowsservercore-1809

ENV sonarqube_download_url "https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-6.5.zip"

ENV sonar_jdbc_url "!"
ENV sonar_jdbc_username "!"
ENV sonar_jdbc_password "!"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

EXPOSE 9000

COPY Start.ps1 /

RUN Invoke-WebRequest $env:sonarqube_download_url -OutFile '/SonarQube.zip' -UseBasicParsing ; \
    Expand-Archive -Path '/SonarQube.zip' -Destination '/SonarQubeTemp' ; \
    Move-Item -Path '/SonarQubeTemp/*' -Destination '/SonarQube' ; \
	Remove-Item -Path '/SonarQube/extensions/plugins' -Recurse -Force; \
    Remove-Item -Force -Recurse '/SonarQubeTemp' ; \
    Remove-Item -Force '/SonarQube.zip' ;

CMD .\Start.ps1 -sonar_jdbc_url $env:sonar_jdbc_url -sonar_jdbc_username $env:sonar_jdbc_username -sonar_jdbc_password $env:sonar_jdbc_password -Verbose