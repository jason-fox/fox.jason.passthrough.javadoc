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
    Method Summary
  -->
  <xsl:template name="add-method-summary">
    <table class=" topic/table " outputclass="method_summary">
      <tgroup class=" topic/tgroup " cols="2">
        <colspec class=" topic/colspec " colname="c1" colnum="1" colwidth="25%"/>
        <colspec class=" topic/colspec " colname="c2" colnum="2" colwidth="75%"/>
        <thead class=" topic/thead ">
          <row class=" topic/row ">
            <entry class=" topic/entry " colname="c1" dita-ot:x="1" align="left">
              Modifier and Type
            </entry>
            <entry class=" topic/entry " colname="c2" dita-ot:x="2" align="left">
              Method and Description
            </entry>
          </row>
        </thead>
        <tbody class=" topic/tbody ">
          <xsl:for-each select="method">
            <xsl:sort select="@name"/>
            <row class=" topic/row ">
              <entry class=" topic/entry " colname="c1"  dita-ot:x="1" align="left">
                <codeph class=" pr-d/codeph ">
                  <xsl:value-of select="dita-ot:addZeroWidthSpaces(child::return/@qualified)"/>
                  <xsl:apply-templates select="child::return/generic"/>
                </codeph>
              </entry>
               <entry class=" topic/entry " colname="c2"  dita-ot:x="2" align="left">
                <codeph class=" pr-d/codeph ">
                  <xref class="- topic/xref " format="dita" type="table">
                    <xsl:attribute name="href">
                      <xsl:value-of select="concat('#', parent::*/@qualified, '/methods_', @name)"/>
                      <xsl:if test="count(../method[@name=@name])&gt;1">
                        <xsl:value-of select="count(following-sibling::method[@name=@name])"/>
                      </xsl:if>
                    </xsl:attribute>
                    <xsl:processing-instruction name="ditaot">
                      <xsl:text>usertext</xsl:text>
                    </xsl:processing-instruction>
                    <xsl:value-of select="@name"/>
                  </xref>
                  <xsl:call-template name="add-signature"/>
                </codeph>
                  <xsl:if test="comment">
                    <xsl:value-of select="concat (' - ',substring-before(comment,'.'),'.')"/>
                  </xsl:if>
              </entry>
            </row>
          </xsl:for-each>
        </tbody>
      </tgroup>
    </table>
  </xsl:template>
  <!--
      Method Details
  -->
  <xsl:template match="method">
      <table class=" topic/table " outputclass="method_details">
        <xsl:attribute name="id">
          <xsl:value-of select="concat('methods_',@name)"/>
          <xsl:if test="count(../method[@name=@name])&gt;1">
            <xsl:value-of select="count(following-sibling::method[@name=@name])"/>
          </xsl:if>
        </xsl:attribute>
        <tgroup class=" topic/tgroup " cols="1">
          <colspec class=" topic/colspec " colname="c1" colnum="1" colwidth="100%"/>
          <thead class=" topic/thead ">
            <row class=" topic/row ">
              <entry class=" topic/entry " colname="c1" dita-ot:x="1" align="left">
                <xsl:value-of select="@name"/>
              </entry>
            </row>
          </thead>
          <tbody class=" topic/tbody ">
             <row class=" topic/row ">
              <entry class=" topic/entry " colname="c1"  dita-ot:x="1" align="left">
                <codeblock class=" pr-d/codeblock ">
                  <xsl:value-of select="concat(@scope, ' ')"/>
                  <xsl:if test="@static='true'">
                    <xsl:text>static </xsl:text>
                  </xsl:if>
                  <xsl:value-of select="replace(child::return/@qualified,'^.*\.','')"/>
                  <xsl:apply-templates select="child::return/generic"/>
                  <xsl:value-of select="concat(' ', @name)"/>
                  <xsl:call-template name="add-signature"/>
                </codeblock>
                <p class="- topic/p ">
                  <xsl:value-of select="comment"/>
                </p>
                <xsl:call-template name="parameter-description"/>
                <xsl:call-template name="return-description"/>
              </entry>
            </row>
          </tbody>
        </tgroup>
      </table>
    <p class="- topic/p "/>
  </xsl:template>
  <!--
    Create a method signature based on the parameter set
  -->
  <xsl:template name="add-signature">
    <xsl:text>(</xsl:text>
    <xsl:for-each select="parameter">
      <xsl:value-of select="replace(type/@qualified,'^.*\.','')"/>
      <xsl:apply-templates select="type/generic"/>
      <xsl:value-of select="type/@dimension"/>
      <xsl:value-of select="concat(' ', @name)"/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>)</xsl:text>
  </xsl:template>
  <!--
    Detailed description of each parameter
  -->
  <xsl:template name="parameter-description">
    <xsl:if test="parameter">
      <p class="- topic/p ">
        <b class=" hi-d/b ">
          <xsl:text>Parameters:</xsl:text>
        </b>
      </p>
      <ul class=" topic/ul ">
        <xsl:for-each select="parameter">
          <xsl:variable name="pcount" select="position()"/>
          <li class=" topic/li ">
            <codeph class=" pr-d/codeph ">
              <xsl:value-of select="concat(@name, ' ')"/>
            </codeph>
            <xsl:if test="parent::method/tag[$pcount]/@text">
              <xsl:value-of select="concat(' - ',parent::method/tag[$pcount]/@text)"/>
            </xsl:if>
          </li>
        </xsl:for-each>
      </ul>
    </xsl:if>
  </xsl:template>

  <!--
    Detailed description of the return, either signature or text description
  -->
  <xsl:template name="return-description">
    <xsl:if test="child::return[not(@qualified='void')]">
      <p class="- topic/p ">
        <b class=" hi-d/b ">
          <xsl:text>Returns:</xsl:text>
        </b>
      </p>
      <p class="- topic/p ">
        <xsl:choose >
          <xsl:when test="tag[last()]/@text">
            <xsl:value-of select="tag[last()]/@text"/>
          </xsl:when>
          <xsl:otherwise>
            <codeph class=" pr-d/codeph ">
              <xsl:value-of select="child::return/@qualified"/>
              <xsl:value-of select="child::return/@dimension"/>
            </codeph>
          </xsl:otherwise>
        </xsl:choose>
      </p>
    </xsl:if>
  </xsl:template>
  <!--
      Add Generics to signatures
  -->
  <xsl:template match="generic">
    <xsl:text>&#8203;&lt;</xsl:text>
    <xsl:value-of select="replace(@qualified,'^.*\.','')"/>
    <xsl:apply-templates select="generic"/>
    <xsl:text>&gt;&#8203;</xsl:text>
  </xsl:template>

  <xsl:function name="dita-ot:addZeroWidthSpaces">
    <xsl:param name="text" as="xs:string"/>
    <xsl:value-of select="replace($text,'\.','.&#8203;')"/>
  </xsl:function>
</xsl:stylesheet>