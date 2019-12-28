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

<xsl:template name="inheritance-java-lang">
    <xsl:param name = "extends" />
      <xsl:choose>
        <xsl:when test="$extends='java.lang.RuntimeException'">
          <xsl:call-template name="inheritance-methods-exception"/>
        </xsl:when>
        <!--xsl:when test="$extends='java.lang.Object'">
        </xsl:when-->
      </xsl:choose>
      <xsl:call-template name="inheritance-methods-object"/>
  </xsl:template>
  <!--
    List methods from java.lang.Object
  -->
  <xsl:template name="inheritance-methods-object">
    <p class="- topic/p "/>
    <table class=" topic/table " outputclass="method_details">
      <xsl:call-template name="mini-table" >
        <xsl:with-param name="header" select="'Methods inherited from class java.lang.Object'"/>
        <xsl:with-param name="body">
          <codeph class=" pr-d/codeph ">
            <xsl:attribute name="xtrc" select="concat('codeph:',generate-id(.),'10')"/>
            <xsl:text>clone, equals, finalize, getClass, hashCode, notify, notifyAll, toString, wait, wait, wait</xsl:text>
          </codeph>
        </xsl:with-param>
      </xsl:call-template>
    </table>
  </xsl:template>
    <!--
    List methods from java.lang.RuntimeException
  -->
  <xsl:template name="inheritance-methods-exception">
    <p class="- topic/p "/>
    <table class=" topic/table " outputclass="method_details">
      <xsl:call-template name="mini-table" >
        <xsl:with-param name="header" select="'Methods inherited from class java.lang.Throwable'"/>
        <xsl:with-param name="body">
          <codeph class=" pr-d/codeph ">
            <xsl:attribute name="xtrc" select="concat('codeph:',generate-id(.),'11')"/>
            <xsl:text>addSuppressed, fillInStackTrace, getCause, getLocalizedMessage, getMessage, getStackTrace, getSuppressed, initCause, printStackTrace, printStackTrace, printStackTrace, setStackTrace, toString</xsl:text>
          </codeph>
        </xsl:with-param>
      </xsl:call-template>
    </table>
  </xsl:template>
</xsl:stylesheet>