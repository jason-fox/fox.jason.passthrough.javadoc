<h1>Install</h1>

The DITA-OT JavaDoc plug-in has been tested against [DITA-OT 3.x](http://www.dita-ot.org/download). The plugin requires the XSLT 3.0 support
found in the [Saxon9.8HE](https://www.saxonica.com/html/download/java.html) library, so the mimimum DITA-OT version is therefore 3.3.
It is recommended that you upgrade to the latest version.

### Installing DITA-OT

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" width="55" height="55"></a>

The DITA-OT JavaDoc plug-in is a file reader for the DITA Open Toolkit.

-   Full installation instructions for downloading DITA-OT can be found
    [here](https://www.dita-ot.org/3.4/topics/installing-client.html).

    1.  Download the `dita-ot-3.4.zip` package from the project website at
        [dita-ot.org/download](https://www.dita-ot.org/download)
    2.  Extract the contents of the package to the directory where you want to install DITA-OT.
    3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable.

    This defines the necessary environment variable to run the `dita` command from the command line.

```bash
curl -LO https://github.com/dita-ot/dita-ot/releases/download/3.4/dita-ot-3.4.zip
unzip -q dita-ot-3.4.zip
rm dita-ot-3.4.zip
```

### Installing the Plug-in

-   Run the plug-in installation commands:

```bash
dita --install https://github.com/doctales/org.doctales.xmltask/archive/master.zip
dita --install https://github.com/jason-fox/fox.jason.passthrough/archive/master.zip
dita --install https://github.com/jason-fox/fox.jason.passthrough.javadoc/archive/master.zip
```

The `dita` command line tool requires no additional configuration.