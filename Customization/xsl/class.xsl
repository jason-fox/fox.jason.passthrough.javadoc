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
     Class Overview
  -->
  <xsl:template match="class">
    <topic domains="(topic abbrev-d) a(props deliveryTarget) (topic equation-d) (topic hazard-d) (topic hi-d) (topic indexing-d) (topic markup-d) (topic mathml-d) (topic pr-d) (topic relmgmt-d) (topic sw-d) (topic svg-d) (topic ui-d) (topic ut-d) (topic markup-d xml-d)" xmlns:dita="http://dita-ot.sourceforge.net/ns/201007/dita-ot" class="- topic/topic " ditaarch:DITAArchVersion="1.3" props="javadoc">
      <xsl:attribute name="id">
        <xsl:value-of select="@qualified"/>
      </xsl:attribute>
      <xsl:attribute name="outputclass">
        <xsl:text>class</xsl:text>
      </xsl:attribute>
      <title class="- topic/title "><xsl:value-of select="concat ('Class ',@name)"/></title>
      <titlealts class="- topic/titlealts ">
        <navtitle class="- topic/navtitle ">
          <xsl:value-of select="@name"/>
        </navtitle>
        <searchtitle class="- topic/searchtitle ">
          <xsl:value-of select="@name"/>
        </searchtitle>
      </titlealts>
      <body class="- topic/body ">
        <codeblock class=" pr-d/codeblock ">
          <xsl:value-of select="concat(@scope, ' ', name(), ' ')"/>
          <b class=" hi-d/b "><xsl:value-of select="@name"/></b>
          <xsl:value-of select="concat(' extends ', class/@qualified)"/>
        </codeblock>
        <xsl:call-template name="add-description"/>
        <xsl:if test="constructor">
          <!-- Class Constructor Summary -->
          <section class="- topic/section " outputclass="contructors_summary">
            <title class="- topic/title " >Constructor Summary</title>
            <xsl:call-template name="add-constructor-summary"/>
          </section>
        </xsl:if>
        <xsl:if test="method">
          <!-- Class Method Summary -->
           <section class="- topic/section " outputclass="methods_summary">
            <title class="- topic/title " >Method Summary</title>
            <xsl:call-template name="add-method-summary"/>
          </section>
        </xsl:if>
        <xsl:if test="constructor">
          <!-- Constructor Detail -->
          <section class="- topic/section " outputclass="constructors">
            <xsl:attribute name="id">
              <xsl:value-of select="concat(@qualified, '_constructors')"/>
            </xsl:attribute>
            <title class="- topic/title " >Constructor Detail</title>
            <xsl:apply-templates select="constructor" >
              <xsl:sort select="@signature"/>
            </xsl:apply-templates>
          </section>
        </xsl:if>

        <xsl:if test="method">
          <!-- Method Detail-->
          <section class="- topic/section " outputclass="methods">
            <xsl:attribute name="id">
              <xsl:value-of select="concat(@qualified, '_methods')"/>
            </xsl:attribute>
            <title class="- topic/title " >Method Detail</title>
            <xsl:apply-templates select="method">
              <xsl:sort select="@name" />
            </xsl:apply-templates>
          </section>
        </xsl:if>
      </body>
    </topic>
  </xsl:template>

  <!--
    Constructor Summary
  -->
  <xsl:template name="add-constructor-summary">
    <table class=" topic/table " outputclass="constructor_summary">
      <tgroup class=" topic/tgroup " cols="2">
        <colspec class=" topic/colspec " colname="c1" colnum="1" colwidth="100%"/>
        <thead class=" topic/thead ">
          <row class=" topic/row ">
            <entry class=" topic/entry " colname="c1" dita-ot:x="1" align="left">
              Constructor and Description
            </entry>
          </row>
        </thead>
        <tbody class=" topic/tbody ">
          <xsl:for-each select="constructor">
            <xsl:sort select="@name"/>
            <row class=" topic/row ">
               <entry class=" topic/entry " colname="c2"  dita-ot:x="2" align="left">
                <codeph class=" pr-d/codeph ">
                  <xref class="- topic/xref " format="dita" type="table">
                    <xsl:attribute name="href">
                      <xsl:value-of select="concat('#', parent::*/@qualified, '/constructors_', @name)"/>
                      <xsl:if test="count(../constructor[@name=@name])&gt;1">
                        <xsl:value-of select="count(following-sibling::constructor[@name=@name])"/>
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
      Constructor Details
  -->
  <xsl:template match="constructor">
    <table class=" topic/table " outputclass="constructor_details">
        <xsl:attribute name="id">
          <xsl:value-of select="concat('constructors_',@name)"/>
          <xsl:if test="count(../constructor[@name=@name])&gt;1">
            <xsl:value-of select="count(following-sibling::constructor[@name=@name])"/>
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
                <codeph class=" pr-d/codeph ">
                   <xsl:value-of select="@name"/>
                   <xsl:call-template name="add-signature"/>
                </codeph>
                <p class="- topic/p ">
                  <xsl:value-of select="comment"/>
                </p>
                <xsl:call-template name="parameter-description"/>
              </entry>
            </row>
          </tbody>
        </tgroup>
      </table>
    <p class="- topic/p "/>
  </xsl:template>
</xsl:stylesheet>
