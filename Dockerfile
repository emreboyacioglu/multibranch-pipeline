FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build-env
WORKDIR /app

# Copy csproj and restore
COPY ./devops-demo/*.csproj ./
RUN dotnet restore
RUN dotnet build  -c Release

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Generate runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "devops-demo.dll"]