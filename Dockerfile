FROM mcr.microsoft.com/dotnet/core/runtime:3.1
WORKDIR /app
COPY usr/src/multibranch-pipeline/bin/Release/netcoreapp3.1/publish/ App/
ENTRYPOINT ["dotnet", "devops-demo.dll"]