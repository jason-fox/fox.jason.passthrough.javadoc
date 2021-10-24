<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA-OT JavaDoc Plug-in project.
  See the accompanying LICENSE file for applicable licenses.
-->
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
  version="2.0"
>
  <!--
     Interface Overview
  -->
  <xsl:template match="interface">
    <topic
      domains="(topic abbrev-d) a(props deliveryTarget) (topic equation-d) (topic hazard-d) (topic hi-d) (topic indexing-d) (topic markup-d) (topic mathml-d) (topic pr-d) (topic relmgmt-d) (topic sw-d) (topic svg-d) (topic ui-d) (topic ut-d) (topic markup-d xml-d)"
      xmlns:dita="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
      class="- topic/topic "
      props="javadoc"
    >
      <xsl:attribute name="id">
        <xsl:value-of select="@qualified"/>
      </xsl:attribute>
      <xsl:attribute name="outputclass">
        <xsl:text>interface</xsl:text>
      </xsl:attribute>
      <title class="- topic/title "><xsl:value-of select="concat('Interface ',@name)"/></title>
      <titlealts class="- topic/titlealts ">
        <navtitle class="- topic/navtitle ">
          <xsl:value-of select="@name"/>
        </navtitle>
        <searchtitle class="- topic/searchtitle ">
          <xsl:value-of select="@name"/>
        </searchtitle>
      </titlealts>
      <body class="- topic/body " outputclass="java">
        <codeblock class="+ topic/pre pr-d/codeblock ">
          <xsl:attribute name="xtrc" select="concat('codeblock:',generate-id(.),'7')"/>
          <xsl:value-of select="concat(@scope, ' interface ')"/>
          <b class="+ topic/ph hi-d/b ">
          	<xsl:variable name="class" select="@name"/>
		        <xsl:call-template name="add-class-link">
		          <xsl:with-param name="class" select="$class"/>
		        </xsl:call-template>
        	</b>
        </codeblock>
        <xsl:call-template name="add-description"/>
      
        <xsl:if test="method">
          <!-- Interface Method Summary -->
          <section class="- topic/section " outputclass="methods_summary">
            <title class="- topic/title ">
            	<xsl:text>Method Summary</xsl:text>
            </title>
            <xsl:call-template name="add-method-summary"/>
          </section>
        </xsl:if>
     
        <xsl:if test="method">
          <!-- Interface Method Details -->
          <section class="- topic/section " outputclass="methods">
            <xsl:attribute name="id">
              <xsl:value-of select="concat(@qualified, '_methods')"/>
            </xsl:attribute>
            <title class="- topic/title ">
            	<xsl:text>Method Detail</xsl:text>
            </title>
            <xsl:apply-templates select="method">
              <xsl:sort select="@name"/>
            </xsl:apply-templates>
           </section>
        </xsl:if>
      </body>
    </topic>
  </xsl:template>
</xsl:stylesheet>
