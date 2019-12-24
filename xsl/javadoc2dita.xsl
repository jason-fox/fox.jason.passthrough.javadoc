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

</xsl:stylesheet>