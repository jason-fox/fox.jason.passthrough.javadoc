# JavaDoc Plugin for DITA-OT [<img src="https://jason-fox.github.io/fox.jason.passthrough.javadoc/javadoc.png" align="right" width="300">](http://javadocdita-ot.rtfd.io/)

[![license](https://img.shields.io/github/license/jason-fox/fox.jason.passthrough.javadoc.svg)](http://www.apache.org/licenses/LICENSE-2.0)
[![DITA-OT 3.7](https://img.shields.io/badge/DITA--OT-3.7-blue.svg)](http://www.dita-ot.org/3.7)
[![CI](https://github.com/jason-fox/fox.jason.passthrough.javadoc/workflows/CI/badge.svg)](https://github.com/jason-fox/fox.jason.passthrough.javadoc/actions?query=workflow%3ACI)
[![Coverage Status](https://coveralls.io/repos/github/jason-fox/fox.jason.passthrough.javadoc/badge.svg?branch=master)](https://coveralls.io/github/jason-fox/fox.jason.passthrough.javadoc?branch=master)
[![Documentation Status](https://readthedocs.org/projects/javadocdita-ot/badge/?version=latest)](https://javadocdita-ot.readthedocs.io/en/latest/?badge=latest)

This is a [DITA-OT Plug-in](https://www.dita-ot.org/plugins) used to auto-create valid DITA-based JavaDoc documentation.
The initial source of the documentation can be generated directly using the
[JavaDoc XML Doclet](https://github.com/MarkusBernhardt/xml-doclet). The XML file can be added to the source and
processed as if it had been written in DITA.

<details>
<summary><strong>Table of Contents</strong></summary>

-   [Background](#background)
-   [Install](#install)
    -   [Installing DITA-OT](#installing-dita-ot)
    -   [Installing the Plug-in](#installing-the-plug-in)
-   [Usage](#usage)
-   [License](#license)

</details>

## Background

[<img src="https://jason-fox.github.io/fox.jason.passthrough.javadoc/javalogo.png" align="right" height="55">](https://docs.oracle.com/javase/1.5.0/docs/guide/javadoc/index.html)

[JavaDoc](https://docs.oracle.com/javase/1.5.0/docs/guide/javadoc/index.html) is a tool that parses the declarations and
documentation comments in a set of source files and produces a set of HTML pages describing the classes, interfaces,
constructors, methods, and fields.

JavaDoc supports doclets used to customize JavaDoc output. A doclet is a program written with the Doclet API that
specifies the content and format of the output to be generated by the Javadoc tool.

A library exists to preprocess JavaDoc comments from Java source code to a XML document. It can be downloaded
[here](https://github.com/MarkusBernhardt/xml-doclet). This DITA-OT plugin processes a JavaDoc XML and the converts it
to DITA allowing the generation of PDF API documentation.

#### Sample JavaDoc

```java
/**
 * Effector is the interface for Casbin effectors.
 */
public interface Effector {
    /**
     * mergeEffects merges all matching results collected by the enforcer into a single decision.
     *
     * @param expr the expression of [policy_effect].
     * @param effects the effects of all matched rules.
     * @param results the matcher results of all matched rules.
     * @return the final effect.
     */
    boolean mergeEffects(String expr, Effect[] effects, float[] results);
}
```

#### Sample DITA Output

> ![](https://jason-fox.github.io/fox.jason.passthrough.javadoc/javadoc-output.png)

## Install

The DITA-OT JavaDoc plug-in has been tested against [DITA-OT 3.x](http://www.dita-ot.org/download). The plugin requires
the XSLT 3.0 support found in the [Saxon9.8HE](https://www.saxonica.com/html/download/java.html) library, so the mimimum
DITA-OT version is therefore 3.3. It is recommended that you upgrade to the latest version.

### Installing DITA-OT

<a href="https://www.dita-ot.org"><img src="https://www.dita-ot.org/images/dita-ot-logo.svg" align="right" height="55"></a>

The DITA-OT JavaDoc plug-in is a file reader for the DITA Open Toolkit.

-   Full installation instructions for downloading DITA-OT can be found
    [here](https://www.dita-ot.org/3.7/topics/installing-client.html).

    1.  Download the `dita-ot-3.7.zip` package from the project website at
        [dita-ot.org/download](https://www.dita-ot.org/download)
    2.  Extract the contents of the package to the directory where you want to install DITA-OT.
    3.  **Optional**: Add the absolute path for the `bin` directory to the _PATH_ system variable.

    This defines the necessary environment variable to run the `dita` command from the command line.

```console
curl -LO https://github.com/dita-ot/dita-ot/releases/download/3.7/dita-ot-3.7.zip
unzip -q dita-ot-3.7.zip
rm dita-ot-3.7.zip
```

### Installing the Plug-in

-   Run the plug-in installation commands:

```console
dita install https://github.com/jason-fox/fox.jason.passthrough.javadoc/archive/master.zip
```

The `dita` command line tool requires no additional configuration.

---

## Usage

If you are using maven you can generate XML-based JavaDoc by adding the following plug-in to your `pom.xml`. JavaDoc
will be generated using the `mvn package` command.

```xml
<project>
  ...
  <plugin>
    <groupId>org.apache.maven.plugins</groupId>
    <artifactId>maven-javadoc-plugin</artifactId>
    <executions>
      <execution>
        <id>xml-doclet</id>
        <phase>prepare-package</phase>
        <goals>
          <goal>javadoc</goal>
        </goals>
        <configuration>
          <doclet>com.github.markusbernhardt.xmldoclet.XmlDoclet</doclet>
          <additionalparam>-d ${project.build.directory} -filename ${project.artifactId}-${project.version}-javadoc.xml</additionalparam>
          <useStandardDocletOptions>false</useStandardDocletOptions>
          <docletArtifact>
            <groupId>com.github.markusbernhardt</groupId>
            <artifactId>xml-doclet</artifactId>
            <version>1.0.5</version>
          </docletArtifact>
        </configuration>
    </execution>
    </executions>
  </plugin>
  ...
</project>
```

If you are not using maven, you can use the
[jar-with-dependencies](http://search.maven.org/remotecontent?filepath=com/github/markusbernhardt/xml-doclet/1.0.5/xml-doclet-1.0.5-jar-with-dependencies.jar),
which contains all required libraries.

```console
javadoc -doclet com.github.markusbernhardt.xmldoclet.XmlDoclet \
    -docletpath xml-doclet-1.0.5-jar-with-dependencies.jar \
   [Javadoc- and XmlDoclet-Options]
```

Once the source XML has been created, add it to the `*.ditamap` and mark it for **JavaDoc** processing, by labelling it
with `format="javadoc"` within the `*.ditamap` as shown:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE bookmap PUBLIC "-//OASIS//DTD DITA BookMap//EN" "bookmap.dtd">
<bookmap>
    ...etc
    <appendices toc="yes" print="yes">
      <topicmeta>
        <navtitle>Appendices</navtitle>
      </topicmeta>
      <appendix format="dita" href="topic.dita">
      	<topicref format="javadoc" type="topic" href="javadoc.xml"/>
      </appendix>
   </appendices>
</bookmap>
```

The additional file will be converted to a `*.dita` file and will be added to the build job without further processing.
Unless overridden, the `navtitle` of the included topic will be the same as root name of the file. Any underscores in
the filename will be replaced by spaces in title.

## License

[Apache 2.0](LICENSE) © 2019 - 2021 Jason Fox