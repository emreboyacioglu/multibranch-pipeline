FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY multibranch-pipeline/*.csproj ./multibranch-pipeline/
RUN dotnet restore

# copy everything else and build app
COPY multibranch-pipeline/. ./multibranch-pipeline/
WORKDIR /app/multibranch-pipeline
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:3.0 AS runtime
WORKDIR /app
COPY --from=build /app/multibranch-pipeline/out ./
ENTRYPOINT ["dotnet", "devops-demo.dll"]