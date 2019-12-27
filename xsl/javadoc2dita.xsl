<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA-OT JavaDoc Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
                version="2.0">
  
  <xsl:param name="output.dir.uri"/>

  <xsl:include href="../Customization/xsl/class.xsl"/>
  <xsl:include href="../Customization/xsl/enum.xsl"/>
  <xsl:include href="../Customization/xsl/interface.xsl"/>
  <xsl:include href="../Customization/xsl/method.xsl"/>
  <xsl:include href="../Customization/xsl/package.xsl"/>
  <xsl:include href="../Customization/xsl/java-lang.xsl"/>

  <!--
     Overall API Reference listing.
  -->
  <xsl:template match="/">
    <topic id="sample" domains="(topic abbrev-d) a(props deliveryTarget) (topic equation-d) (topic hazard-d) (topic hi-d) (topic indexing-d) (topic markup-d) (topic mathml-d) (topic pr-d) (topic relmgmt-d) (topic sw-d) (topic svg-d) (topic ui-d) (topic ut-d) (topic markup-d xml-d)" xmlns:dita="http://dita-ot.sourceforge.net/ns/201007/dita-ot" class="- topic/topic " ditaarch:DITAArchVersion="1.3" props="javadoc">
      <title class="- topic/title ">API Reference</title>
      <body class="- topic/body ">
        <section class="- topic/section ">
          <title class="- topic/title " >Packages</title>
          <ul class=" topic/ul ">
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
    Formatted description
  -->
  <xsl:template name="add-description">
    <xsl:if test="comment">
      <lines class=" topic/lines "><xsl:value-of select="comment"/></lines>
    </xsl:if>
  </xsl:template>

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

  <xsl:template name="mini-table">
    <xsl:param name = "header" />
    <xsl:param name = "body" />
    <tgroup class=" topic/tgroup " cols="1">
      <colspec class=" topic/colspec " colname="c1" colnum="1" colwidth="100%"/>
      <thead class=" topic/thead ">
        <row class=" topic/row ">
          <entry class=" topic/entry " colname="c1" dita-ot:x="1" align="left">
            <xsl:copy-of select="$header"/>
          </entry>
        </row>
      </thead>
      <tbody class=" topic/tbody ">
         <row class=" topic/row ">
          <entry class=" topic/entry " colname="c1" dita-ot:x="1" align="left">
            <xsl:copy-of select="$body"/>
          </entry>
        </row>
      </tbody>
    </tgroup>

  </xsl:template>

</xsl:stylesheet>