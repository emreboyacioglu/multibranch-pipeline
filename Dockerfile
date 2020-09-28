FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY multibranch-pipeline/devops-demo/*.csproj ./devops-demo/
RUN dotnet restore

# copy everything else and build app
COPY devops-demo/. ./devops-demo/
WORKDIR /app/devops-demo
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
WORKDIR /app
COPY --from=build /app/devops-demo/out ./
ENTRYPOINT ["dotnet", "devops-demo.dll"]