FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
WORKDIR /app  
COPY ./devops-demo/bin/Release/netcoreapp3.1/devops-demo.dll ./
ENTRYPOINT ["dotnet", "devops-demo.dll"]