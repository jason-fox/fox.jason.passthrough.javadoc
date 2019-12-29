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

  <xsl:template match="*" mode="html">
    <xsl:apply-templates mode="html"/>
  </xsl:template>

  <xsl:template match="p" mode="html">
    <p class="- topic/p ">
      <xsl:apply-templates mode="html"/>
    </p>
  </xsl:template>

  <xsl:template match="ul" mode="html">
    <ul class=" topic/ul ">
      <xsl:apply-templates mode="html"/>
    </ul>
  </xsl:template>

  <xsl:template match="ol" mode="html">
    <ol class=" topic/ol ">
      <xsl:apply-templates mode="html"/>
    </ol>
  </xsl:template>

  <xsl:template match="li" mode="html">
    <xsl:choose>
      <xsl:when test="../name()='ul'">
        <li class=" topic/li ">
          <xsl:apply-templates mode="html"/>
        </li>
      </xsl:when>
      <xsl:when test="../name()='ol'">
        <li class=" topic/li ">
          <xsl:apply-templates mode="html"/>
        </li>
      </xsl:when>
      <xsl:otherwise>
        <ul class=" topic/ul ">
          <li class=" topic/li ">
            <xsl:apply-templates mode="html"/>
          </li>
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="code" mode="html">
    <codeph class=" pr-d/codeph ">
      <xsl:apply-templates mode="html"/>
    </codeph>
  </xsl:template>

  <xsl:template match="b|strong" mode="html">
    <b class=" hi-d/b ">
      <xsl:apply-templates mode="html"/>
    </b>
  </xsl:template>

  <xsl:template match="em|emphasis|i" mode="html">
    <i class=" hi-d/i ">
      <xsl:apply-templates mode="html"/>
    </i>
  </xsl:template>

  <xsl:template match="a" mode="html">
    <xref class=" topic/xref " format="dita" scope="external">
      <xsl:attribute name="href">
        <xsl:value-of select="@href"/>
      </xsl:attribute>
      <xsl:apply-templates mode="html"/>
    </xref>
  </xsl:template>

  <xsl:template match="text()" mode="html">
    <xsl:variable name="text" select="."/>
    <xsl:choose>
      <xsl:when test="../name()='root'">
        <xsl:choose>
          <xsl:when test="contains($text,'&#10;&#10;') ">
            <lines class=" topic/lines ">
              <xsl:value-of select="$text"/>
            </lines>
          </xsl:when>
          <xsl:otherwise>
            <p class="- topic/p ">
              <xsl:value-of select="$text"/>
            </p>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>