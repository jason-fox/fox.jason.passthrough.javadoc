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
  <!--
    Package Summary
  -->
  <xsl:template name="add-package-summary">
    <li class=" topic/li ">
      <xref class="- topic/xref " format="dita" scope="local" type="topic">
        <xsl:attribute name="href">
          <xsl:value-of select="concat('#', @name)"/>
        </xsl:attribute>
        <xsl:processing-instruction name="ditaot">
          <xsl:text>usertext</xsl:text>
        </xsl:processing-instruction>
        <xsl:value-of select="@name"/>
      </xref>
      <xsl:if test="comment">
        <xsl:value-of select="concat (' - ',substring-before(comment,'.'),'.')"/>
      </xsl:if>
    </li>
  </xsl:template>
  <!--
     Package Overview
  -->
  <xsl:template match="package">
    <topic domains="(topic abbrev-d) a(props deliveryTarget) (topic equation-d) (topic hazard-d) (topic hi-d) (topic indexing-d) (topic markup-d) (topic mathml-d) (topic pr-d) (topic relmgmt-d) (topic sw-d) (topic svg-d) (topic ui-d) (topic ut-d) (topic markup-d xml-d)" xmlns:dita="http://dita-ot.sourceforge.net/ns/201007/dita-ot" class="- topic/topic " ditaarch:DITAArchVersion="1.3" props="javadoc">
      <xsl:attribute name="id">
        <xsl:value-of select="@name"/>
      </xsl:attribute>
      <xsl:attribute name="outputclass">
        <xsl:text>package</xsl:text>
      </xsl:attribute>
      <title class="- topic/title ">Package <xsl:value-of select="@name"/></title>
      <titlealts class="- topic/titlealts ">
        <navtitle class="- topic/navtitle ">
          <xsl:value-of select="@name"/>
        </navtitle>
        <searchtitle class="- topic/searchtitle ">
          <xsl:value-of select="@name"/>
        </searchtitle>
      </titlealts>
      <body class="- topic/body ">
        <xsl:call-template name="add-description"/>
        <xsl:if test="class">
          <section class="- topic/section " outputclass="class_summary">
            <title class="- topic/title " >Class Summary</title>
            <ul class=" topic/ul ">
            <xsl:for-each select="class">
              <xsl:sort select="@name"/>
              <xsl:call-template name="add-items-list"/>
            </xsl:for-each>
            </ul>
          </section>
        </xsl:if>
        <xsl:if test="interface">
           <section class="- topic/section " outputclass="interfaces_summary">
            <title class="- topic/title " >Interface Summary</title>
            <ul class=" topic/ul ">
            <xsl:for-each select="interface">
              <xsl:sort select="@name"/>
              <xsl:call-template name="add-items-list"/>
            </xsl:for-each>
            </ul>
          </section>
        </xsl:if>
        <xsl:if test="enum">
           <section class="- topic/section " outputclass="enums_summary">
            <title class="- topic/title " >Enumeration Summary</title>
            <ul class=" topic/ul ">
            <xsl:for-each select="enum">
              <xsl:sort select="@name"/>
              <xsl:call-template name="add-items-list"/>
            </xsl:for-each>
            </ul>
          </section>
        </xsl:if>
      </body>
      <xsl:apply-templates select="class" >
        <xsl:sort select="@name" />
      </xsl:apply-templates>
      <xsl:apply-templates select="interface" >
        <xsl:sort select="@name" />
      </xsl:apply-templates>
      <xsl:apply-templates select="enum" >
        <xsl:sort select="@name" />
      </xsl:apply-templates>
    </topic>
  </xsl:template>
  <!--
    Summary listing for Classes, Interfaces and Enumeration
  -->
  <xsl:template name="add-items-list">
    <li class=" topic/li ">
      <xref class="- topic/xref " format="dita" scope="local" type="topic">
        <xsl:attribute name="href">
          <xsl:value-of select="concat('#', parent::*/@name, '.', @name)"/>
        </xsl:attribute>
        <xsl:processing-instruction name="ditaot">
          <xsl:text>usertext</xsl:text>
        </xsl:processing-instruction>
        <xsl:value-of select="@name"/>
      </xref>
      <xsl:if test="comment">
        <xsl:value-of select="concat (' - ',substring-before(comment,'.'),'.')"/>
      </xsl:if>
    </li>
  </xsl:template>
</xsl:stylesheet>