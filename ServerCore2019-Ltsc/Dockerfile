FROM mcr.microsoft.com/windows/servercore:ltsc2019

ENV sql_server_2017_CU_url "https://download.microsoft.com/download/C/4/F/C4F908C9-98ED-4E5F-88D5-7D6A5004AEBD/SQLServer2017-KB4508218-x64.exe"
ENV azure_storage_emulator_url "https://download.visualstudio.microsoft.com/download/pr/e9476781-1f65-40e4-b7fd-e6b49840c7de/7028682de076b2dbc1aa5f1e02ec420a/microsoftazurestorageemulator.msi"

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

EXPOSE 10000 10001 10002

RUN New-Item -ItemType Directory -Name 'Build' ; \
    Invoke-WebRequest $env:sql_server_2017_CU_url -OutFile 'C:\Build\SQLServerLocalPatch.exe' -UseBasicParsing ; \
    Invoke-WebRequest $env:azure_storage_emulator_url -OutFile 'C:\Build\microsoftazurestorageemulator.msi' -UseBasicParsing ; \
    Start-Process -FilePath C:\Build\SQLServerLocalPatch.exe -ArgumentList /x:C:\Build\sql-patch-extract, /q -Wait ; \
    Start-Process -FilePath msiexec -ArgumentList /i, C:\Build\sql-patch-extract\1033_enu_lp\x64\setup\x64\sqllocaldb.msi, /quiet, IACCEPTSQLLOCALDBLICENSETERMS=YES -Wait ; \
    & 'C:\Program Files\Microsoft SQL Server\140\Tools\Binn\SqlLocalDB.exe' create ; \
    & 'C:\Program Files\Microsoft SQL Server\140\Tools\Binn\SqlLocalDB.exe' start ; \
    Start-Process -FilePath msiexec -ArgumentList /i, C:\Build\microsoftazurestorageemulator.msi, /quiet -Wait ; \   
    Start-Process -FilePath 'C:\Program Files (x86)\Microsoft SDKs\Azure\Storage Emulator\AzureStorageEmulator.exe' -ArgumentList init -Wait ; \
    Remove-Item -Force -Recurse 'C:\Build\'

COPY Start.ps1 .
CMD ./Start.ps1