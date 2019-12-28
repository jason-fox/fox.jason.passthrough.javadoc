<h1>Usage</h1>

If you are using maven you can generate XML-based JavaDoc by adding the following plug-in to your `pom.xml`. JavaDoc will be generated using the `mvn package` command.

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

If you are not using maven, you can use the [jar-with-dependencies](http://search.maven.org/remotecontent?filepath=com/github/markusbernhardt/xml-doclet/1.0.5/xml-doclet-1.0.5-jar-with-dependencies.jar), which contains all required libraries.

```console
javadoc -doclet com.github.markusbernhardt.xmldoclet.XmlDoclet \
    -docletpath xml-doclet-1.0.5-jar-with-dependencies.jar \
   [Javadoc- and XmlDoclet-Options]
```

Once the source XML has been created, add it to the `*.ditamap` and mark it for **JavaDoc** processing,
by labelling it with `format="javadoc"` within the `*.ditamap` as shown:

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