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
     Class Overview
  -->
  <xsl:template match="class">
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
      <body class="- topic/body " outputclass="java">

        <xsl:variable name="class" select="@qualified"/>
        <xsl:variable name="extends" select="class/@qualified"/>

        <xsl:if
          test="interface or //package/class[@qualified=$extends]/interface or @externalizable='true' or @serializable='true' "
        >
          <p class="- topic/p ">
            <b class="+ topic/ph hi-d/b ">
              <xsl:text>All Implemented Interfaces:</xsl:text>
            </b>
          </p>
          <ul class="- topic/ul ">
            <xsl:for-each select="interface">
              <li class="- topic/li ">
                <xsl:call-template name="add-link">
                  <xsl:with-param name="type" select="'topic'"/>
                  <xsl:with-param name="href" select="concat('#', @qualified)"/>
                  <xsl:with-param name="text" select="replace(@qualified,'^.*\.','')"/>
                </xsl:call-template>
              </li>
            </xsl:for-each>
            <xsl:for-each select="//package/class[@qualified=$extends]/interface">
              <li class="- topic/li ">
                <xsl:call-template name="add-link">
                  <xsl:with-param name="type" select="'topic'"/>
                  <xsl:with-param name="href" select="concat('#', @qualified)"/>
                  <xsl:with-param name="text" select="replace(@qualified,'^.*\.','')"/>
                </xsl:call-template>
              </li>
            </xsl:for-each>
            <xsl:if test="@externalizable='true'">
              <li class="- topic/li ">
                <xsl:text>java.io.Externalizable</xsl:text>
              </li>
            </xsl:if>
            <xsl:if test="@serializable='true'">
              <li class="- topic/li ">
                <xsl:text>java.io.Serializable</xsl:text>
              </li>
            </xsl:if> 
          </ul>
        </xsl:if>
        <xsl:if test="//package/class/class[@qualified=$class]">
          <p class="- topic/p ">
            <b class="+ topic/ph hi-d/b ">
              <xsl:text>Direct Known Subclasses:</xsl:text>
            </b>
          </p>
          <ul class="- topic/ul ">
            <xsl:for-each select="//package/class/class[@qualified=$class]">
               <li class="- topic/li ">
                <xsl:call-template name="add-link">
                  <xsl:with-param name="type" select="'topic'"/>
                  <xsl:with-param name="href" select="concat('#', parent::class/@qualified)"/>
                  <xsl:with-param name="text" select="parent::class/@name"/>
                </xsl:call-template>
              </li>
            </xsl:for-each>
          </ul>
        </xsl:if>

        <codeblock class="+ topic/pre pr-d/codeblock ">
          <xsl:attribute name="xtrc" select="concat('codeblock:',generate-id(.),'1')"/>
          <xsl:value-of select="concat(@scope, ' ', name(), ' ')"/>
          <b class="+ topic/ph hi-d/b "><xsl:value-of select="@name"/></b>
          <xsl:choose>
            <xsl:when test="//package/class[@qualified=$extends]">
                <xsl:text> extends </xsl:text>
                <xsl:call-template name="add-link">
                  <xsl:with-param name="type" select="'topic'"/>
                  <xsl:with-param name="href" select="concat('#', class/@qualified)"/>
                  <xsl:with-param name="text" select="replace(class/@qualified,'^.*\.','')"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="concat(' extends ', $extends)"/>
            </xsl:otherwise>
          </xsl:choose>
        </codeblock>
        <xsl:call-template name="add-description"/>
        <xsl:if test="field">
          <!-- Class Field Summary -->
          <section class="- topic/section " outputclass="fields_summary">
            <title class="- topic/title ">
               <xsl:text>Field Summary</xsl:text>
             </title>
            <xsl:call-template name="add-field-summary"/>
          </section>
        </xsl:if>
        <xsl:if test="constructor">
          <!-- Class Constructor Summary -->
          <section class="- topic/section " outputclass="contructors_summary">
            <title class="- topic/title ">
               <xsl:text>Constructor Summary</xsl:text>
             </title>
            <xsl:call-template name="add-constructor-summary"/>
          </section>
        </xsl:if>
        <!-- Class Method Summary -->
         <section class="- topic/section " outputclass="methods_summary">
          <title class="- topic/title ">
             <xsl:text>Method Summary</xsl:text>
           </title>
          <xsl:if test="method">
            <xsl:call-template name="add-method-summary"/>
          </xsl:if>
          <xsl:call-template name="add-inherited-method-summary"/>
        </section>

         <xsl:if test="field">
          <!-- field Detail -->
          <section class="- topic/section " outputclass="fields">
            <xsl:attribute name="id">
              <xsl:value-of select="concat($class, '_fields')"/>
            </xsl:attribute>
            <title class="- topic/title ">
              <xsl:text>Field Detail</xsl:text>
            </title>
            <xsl:apply-templates select="field">
              <xsl:sort select="@name"/>
            </xsl:apply-templates>
          </section>
        </xsl:if>

        <xsl:if test="constructor">
          <!-- Constructor Detail -->
          <section class="- topic/section " outputclass="constructors">
            <xsl:attribute name="id">
              <xsl:value-of select="concat($class, '_constructors')"/>
            </xsl:attribute>
            <title class="- topic/title ">
              <xsl:text>Constructor Detail</xsl:text>
            </title>
            <xsl:apply-templates select="constructor">
              <xsl:sort select="@signature"/>
            </xsl:apply-templates>
          </section>
        </xsl:if>

        <xsl:if test="method">
          <!-- Method Detail-->
          <section class="- topic/section " outputclass="methods">
            <xsl:attribute name="id">
              <xsl:value-of select="concat($class, '_methods')"/>
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

  <!--
    Constructor Summary
  -->
  <xsl:template name="add-constructor-summary">
    <table class="- topic/table " outputclass="constructor_summary">
      <tgroup class="- topic/tgroup " cols="1">
        <colspec class="- topic/colspec " colname="c1" colnum="1" colwidth="100%"/>
        <thead class="- topic/thead ">
          <row class="- topic/row ">
            <entry class="- topic/entry " colname="c1" dita-ot:x="1" align="left">
               <xsl:text>Constructor and Description</xsl:text>
            </entry>
          </row>
        </thead>
        <tbody class="- topic/tbody ">
          <xsl:for-each select="constructor">
            <xsl:sort select="@name"/>
            <xsl:variable name="constructor" select="@name"/>
            <row class="- topic/row ">
               <entry class="- topic/entry " colname="c1" dita-ot:x="1" align="left">
                <codeph class="+ topic/ph pr-d/codeph ">
                  <xsl:attribute name="xtrc" select="concat('codeph:',generate-id(.),'1')"/>
                  <xsl:call-template name="add-link">
                    <xsl:with-param name="type" select="'table'"/>
                    <xsl:with-param name="href">
                      <xsl:value-of select="concat('#', parent::*/@qualified, '/constructors_', $constructor)"/>
                      <xsl:if test="count(../constructor[@name=$constructor])&gt;1">
                        <xsl:value-of select="count(following-sibling::constructor[@name=$constructor])"/>
                      </xsl:if>
                    </xsl:with-param>
                    <xsl:with-param name="text" select="$constructor"/>
                  </xsl:call-template>
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
    <xsl:variable name="constructor" select="@name"/>
    <xsl:variable name="constructor_details">
      <codeblock class="+ topic/pre pr-d/codeblock ">
        <xsl:attribute name="xtrc" select="concat('codeblock:',generate-id(.),'9')"/>
        <xsl:value-of select="$constructor"/>
        <xsl:call-template name="add-signature"/>
      </codeblock>
      <xsl:call-template name="parse-comment"/>
      <xsl:call-template name="parameter-description"/>
    </xsl:variable>

    <table class="- topic/table " outputclass="constructor_details">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('constructors_',$constructor)"/>
        <xsl:if test="count(../constructor[@name=$constructor])&gt;1">
          <xsl:value-of select="count(following-sibling::constructor[@name=$constructor])"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:call-template name="mini-table">
        <xsl:with-param name="header">
          <xsl:value-of select="$constructor"/>
        </xsl:with-param>
        <xsl:with-param name="body" select="$constructor_details"/>
      </xsl:call-template>
    </table>
    <p class="- topic/p "/>
  </xsl:template>

  <!--
    Field Summary
  -->
  <xsl:template name="add-field-summary">
    <table class="- topic/table " outputclass="field_summary">
      <tgroup class="- topic/tgroup " cols="2">
        <colspec class="- topic/colspec " colname="c1" colnum="1" colwidth="25%"/>
        <colspec class="- topic/colspec " colname="c2" colnum="2" colwidth="75%"/>
        <thead class="- topic/thead ">
          <row class="- topic/row ">
            <entry class="- topic/entry " colname="c1" dita-ot:x="1" align="left">
               <xsl:text>Modifier and Type</xsl:text>
            </entry>
            <entry class="- topic/entry " colname="c2" dita-ot:x="2" align="left">
               <xsl:text>Field and Description</xsl:text>
            </entry>
          </row>
        </thead>
        <tbody class="- topic/tbody ">
          <xsl:for-each select="field">
            <xsl:sort select="@name"/>
            <xsl:variable name="field" select="@name"/>
            <row class="- topic/row ">
              <entry class="- topic/entry " colname="c1" dita-ot:x="1" align="left">
                <codeph class="+ topic/ph pr-d/codeph ">
                  <xsl:attribute name="xtrc" select="concat('codeph:',generate-id(.),'3')"/>
                  <xsl:call-template name="add-modifiers"/>
                  <xsl:call-template name="add-class-link">
                    <xsl:with-param name="class" select="type/@qualified"/>
                  </xsl:call-template>
                  <xsl:apply-templates select="type/generic"/>
                </codeph>
              </entry>
               <entry class="- topic/entry " colname="c2" dita-ot:x="2" align="left">
                <codeph class="+ topic/ph pr-d/codeph ">
                  <xsl:attribute name="xtrc" select="concat('codeph:',generate-id(.),'4')"/>
                  <xsl:call-template name="add-link">
                    <xsl:with-param name="type" select="'table'"/>
                    <xsl:with-param name="href">
                      <xsl:value-of select="concat('#', parent::*/@qualified, '/fields_', $field)"/>
                      <xsl:if test="count(../field[@name=$field])&gt;1">
                        <xsl:value-of select="count(following-sibling::field[@name=$field])"/>
                      </xsl:if>
                    </xsl:with-param>
                    <xsl:with-param name="text" select="$field"/>
                  </xsl:call-template>
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
  <xsl:template match="field">
    <xsl:variable name="field" select="@name"/>
    <xsl:variable name="field_details">
      <codeph class="+ topic/ph pr-d/codeph ">
        <xsl:attribute name="xtrc" select="concat('codeph:',generate-id(.),'5')"/>
        <xsl:value-of select="concat(@scope, ' ')"/>
        <xsl:if test="@static='true'">
          <xsl:text>static </xsl:text>
        </xsl:if>
        <xsl:if test="@final='true'">
          <xsl:text>final </xsl:text>
        </xsl:if>
        <xsl:call-template name="add-class-link">
          <xsl:with-param name="class" select="type/@qualified"/>
        </xsl:call-template>
        <xsl:apply-templates select="type/generic"/>
        <xsl:value-of select="type/@dimension"/>
        <xsl:value-of select="concat(' ',$field)"/>
      </codeph>
      <xsl:call-template name="parse-comment"/>
    </xsl:variable>

    <table class="- topic/table " outputclass="field_details">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('fields_',$field)"/>
        <xsl:if test="count(../field[@name=$field])&gt;1">
          <xsl:value-of select="count(following-sibling::field[@name=$field])"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:call-template name="mini-table">
        <xsl:with-param name="header">
          <xsl:value-of select="$field"/>
        </xsl:with-param>
        <xsl:with-param name="body" select="$field_details"/>
      </xsl:call-template>
    </table>
    <p class="- topic/p "/>
  </xsl:template>
</xsl:stylesheet>
