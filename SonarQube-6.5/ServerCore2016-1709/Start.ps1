param(
[Parameter(Mandatory=$false)]
[string]$sonar_jdbc_url,

[Parameter(Mandatory=$false)]
[string]$sonar_jdbc_username,

[Parameter(Mandatory=$false)]
[string]$sonar_jdbc_password
)

if ((Test-Path C:\SonarQube\conf\sonar.properties.template) -eq $false) {

    Rename-Item -Path C:\SonarQube\conf\sonar.properties -NewName sonar.properties.template
}

if ((Test-Path C:\SonarQube\conf\sonar.properties) -eq $false) {

    New-Item -Name 'sonar.properties' -Path 'C:\SonarQube\conf' -ItemType file    
}

if ($sonar_jdbc_url -ne '!') {

    Add-Content -Path C:\SonarQube\conf\sonar.properties -Value "sonar.jdbc.url=${env:sonar_jdbc_url}"
}

if ($sonar_jdbc_username -ne '!') {

    Add-Content -Path C:\SonarQube\conf\sonar.properties -Value "sonar.jdbc.username=${env:sonar_jdbc_username}"
}

if ($sonar_jdbc_password -ne '!') {

    Add-Content -Path C:\SonarQube\conf\sonar.properties -Value "sonar.jdbc.password=${env:sonar_jdbc_password}"
}

Start-Process C:\SonarQube\bin\windows-x86-64\StartSonar.bat -NoNewWindow -Wait