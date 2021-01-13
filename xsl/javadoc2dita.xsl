<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA-OT JavaDoc Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                version="3.0">
  
  <xsl:param name="output.dir.uri"/>

  <xsl:include href="../Customization/xsl/class.xsl"/>
  <xsl:include href="../Customization/xsl/enum.xsl"/>
  <xsl:include href="../Customization/xsl/html-processing.xsl"/>
  <xsl:include href="../Customization/xsl/interface.xsl"/>
  <xsl:include href="../Customization/xsl/java-lang.xsl"/>
  <xsl:include href="../Customization/xsl/method.xsl"/>
  <xsl:include href="../Customization/xsl/package.xsl"/>

  <!--
     Overall API Reference listing.
  -->
  <xsl:template match="/">
    <topic id="sample" domains="(topic abbrev-d) a(props deliveryTarget) (topic equation-d) (topic hazard-d) (topic hi-d) (topic indexing-d) (topic markup-d) (topic mathml-d) (topic pr-d) (topic relmgmt-d) (topic sw-d) (topic svg-d) (topic ui-d) (topic ut-d) (topic markup-d xml-d)" class="- topic/topic " props="javadoc">
      <title class="- topic/title ">API Reference</title>
      <body class="- topic/body ">
        <section class="- topic/section ">
          <title class="- topic/title " >Packages</title>
          <ul class="- topic/ul ">
          <xsl:for-each select="root/package">
            <xsl:sort select="@name"/>
            <xsl:call-template name="add-package-summary"/>
          </xsl:for-each>
          </ul>
        </section>
      </body>
      <xsl:apply-templates select="root/package">
        <xsl:sort select="@name"/>
      </xsl:apply-templates>
    </topic>
  </xsl:template>
  <!--
    Add a description if one is present.
  -->
  <xsl:template name="add-description">
    <xsl:if test="comment">
      <xsl:call-template name="parse-comment"/>
    </xsl:if>
  </xsl:template>
  <!--
    Formatted description
  -->
  <xsl:template name="parse-comment">
    <xsl:variable name="html-fragment">
      <xsl:try>
        <xsl:copy>
          <xsl:copy-of select="parse-xml-fragment(concat('&lt;root&gt;',comment,'&lt;/root&gt;'))"/>
        </xsl:copy>
        <xsl:catch>
          <xsl:copy>
            <xsl:copy-of select="parse-xml-fragment(concat('&lt;root&gt;',replace(comment,'&lt;p&gt;','&#10;&#10;'),'&lt;/root&gt;'))"/>
          </xsl:copy>
        </xsl:catch>
      </xsl:try>
    </xsl:variable>
    <xsl:apply-templates select="$html-fragment" mode="html"/>
  </xsl:template>

  <!--
    Add an internal cross reference
  -->
  <xsl:template name="add-link">
    <xsl:param name = "type" />
    <xsl:param name = "href" />
    <xsl:param name = "text" />

    <xref class="- topic/xref " format="dita" scope="local">
      <xsl:attribute name="type">
        <xsl:value-of select="$type"/>
      </xsl:attribute>
      <xsl:attribute name="href">
        <xsl:value-of select="$href"/>
      </xsl:attribute>
      <xsl:processing-instruction name="ditaot">
        <xsl:text>usertext</xsl:text>
      </xsl:processing-instruction>
      <xsl:value-of select="$text"/>
    </xref>
  </xsl:template>

  <!--
    Add a full width table consisting of a header 
    and a single row.
  -->
  <xsl:template name="mini-table">
    <xsl:param name = "header" />
    <xsl:param name = "body" />
    <tgroup class="- topic/tgroup " cols="1">
      <colspec class="- topic/colspec " colname="c1" colnum="1" colwidth="100%"/>
      <thead class="- topic/thead ">
        <row class="- topic/row ">
          <entry class="- topic/entry " colname="c1" align="left">
            <xsl:copy-of select="$header"/>
          </entry>
        </row>
      </thead>
      <tbody class="- topic/tbody ">
         <row class="- topic/row ">
          <entry class="- topic/entry " colname="c1" align="left">
            <xsl:copy-of select="$body"/>
          </entry>
        </row>
      </tbody>
    </tgroup>

  </xsl:template>

</xsl:stylesheet>