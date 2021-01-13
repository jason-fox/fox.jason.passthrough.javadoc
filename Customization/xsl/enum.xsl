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
     Enumeration Overview
  -->
  <xsl:template match="enum">
    <topic domains="(topic abbrev-d) a(props deliveryTarget) (topic equation-d) (topic hazard-d) (topic hi-d) (topic indexing-d) (topic markup-d) (topic mathml-d) (topic pr-d) (topic relmgmt-d) (topic sw-d) (topic svg-d) (topic ui-d) (topic ut-d) (topic markup-d xml-d)" xmlns:dita="http://dita-ot.sourceforge.net/ns/201007/dita-ot" class="- topic/topic " ditaarch:DITAArchVersion="1.3" props="javadoc">
      <xsl:attribute name="id">
        <xsl:value-of select="@qualified"/>
      </xsl:attribute>
      <xsl:attribute name="outputclass">
        <xsl:text>enum</xsl:text>
      </xsl:attribute>
      <title class="- topic/title "><xsl:value-of select="concat('Enum ', @name)"/></title>
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
          <xsl:attribute name="xtrc" select="concat('codeblock:',generate-id(.),'2')"/>
          <xsl:value-of select="concat(@scope, ' enum ')"/>
          <b class="+ topic/ph hi-d/b "><xsl:value-of select="@name"/></b>
          <xsl:text> extends </xsl:text>
          <xsl:variable name="class" select="class/@qualified"/>
          <xsl:call-template name="add-class-link">
            <xsl:with-param name="class" select="$class"/>
          </xsl:call-template>
          <xsl:apply-templates select="class/generic"/>
        </codeblock>
        <xsl:call-template name="add-description"/>
        <xsl:if test="constant">
          <!-- Enumeration Constants Summary -->
          <section class="- topic/section " outputclass="constants_summary">
            <title class="- topic/title " >
              <xsl:text>Enum constants</xsl:text>
            </title>
            <xsl:call-template name="add-constant-summary"/>
          </section>
          <!-- Enumeration Method Summary -->
          <section class="- topic/section " outputclass="methods_summary">
            <title class="- topic/title " >
               <xsl:text>Method Summary</xsl:text>
             </title>
            <xsl:call-template name="add-enum-method-summary"/>
          </section>
          <!-- Enumeration Constants Detail -->
          <section class="- topic/section " outputclass="constants">
            <xsl:attribute name="id">
              <xsl:value-of select="concat(@qualified, '_constants')"/>
            </xsl:attribute>
              <title class="- topic/title " >
                <xsl:text>Enum Constant Detail</xsl:text>
              </title>
            <xsl:apply-templates select="constant">
              <xsl:sort select="@name" />
            </xsl:apply-templates>
          </section>
          <!-- Enumeration Method Detail -->
          <section class="- topic/section " outputclass="methods_summary">
            <title class="- topic/title " >Method Detail</title>
            <xsl:call-template name="add-enum-method-detail"/>
          </section>
        </xsl:if>
      </body>
    </topic>
  </xsl:template>

  <!--
    Constant Summary
  -->
  <xsl:template name="add-constant-summary">
    <ul class="- topic/ul ">
      <xsl:for-each select="constant">
        <xsl:sort select="@name"/>
        <xsl:variable name="constant" select="@name"/>
        <li class="- topic/li ">
          <xsl:call-template name="add-link" >
            <xsl:with-param name="type" select="'topic'" />
            <xsl:with-param name="href" select="concat('#', parent::*/@qualified, '/enums_', $constant)" />
            <xsl:with-param name="text" select="$constant" />
          </xsl:call-template>
          <xsl:if test="comment">
            <xsl:value-of select="concat (' - ',substring-before(comment,'.'),'.')"/>
          </xsl:if>
        </li>
     </xsl:for-each>
    </ul>
  </xsl:template>

  <!--
      Enum Constant Details
  -->
  <xsl:template match="constant">

    <xsl:variable name="header">
      <xsl:value-of select="@name"/>
    </xsl:variable>
    
    <xsl:variable name="body">
      <codeblock class="+ topic/pre pr-d/codeblock ">
        <xsl:attribute name="xtrc" select="concat('codeblock:',generate-id(.),'3')"/>
        <xsl:text>public static final </xsl:text>
        <xsl:call-template name="add-class-link">
          <xsl:with-param name="class" select="../class/generic/@qualified"/>
        </xsl:call-template>
        <xsl:value-of select="concat(' ', @name)"/>
      </codeblock>
      <xsl:call-template name="parse-comment"/>
    </xsl:variable>

    <table class="- topic/table " outputclass="enum_details">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('enums_',@name)"/>
      </xsl:attribute>
      <xsl:call-template name="mini-table" >
        <xsl:with-param name="header" select="$header"/>
        <xsl:with-param name="body" select="$body"/>
      </xsl:call-template>
    </table>
    <p class="- topic/p "/>
  </xsl:template>

  <!--
    Enum Method Summary
  -->
  <xsl:template name="add-enum-method-summary">
    <table class="- topic/table " outputclass="method_summary">
      <tgroup class="- topic/tgroup " cols="2">
        <colspec class="- topic/colspec " colname="c1" colnum="1" colwidth="25%"/>
        <colspec class="- topic/colspec " colname="c2" colnum="2" colwidth="75%"/>
        <thead class="- topic/thead ">
          <row class="- topic/row ">
            <entry class="- topic/entry " colname="c1" dita-ot:x="1" align="left">
               <xsl:text>Modifier and Type</xsl:text>
            </entry>
            <entry class="- topic/entry " colname="c2" dita-ot:x="2" align="left">
               <xsl:text>Method and Description</xsl:text>
            </entry>
          </row>
        </thead>
        <tbody class="- topic/tbody ">
          <row class="- topic/row ">
            <entry class="- topic/entry " colname="c1"  dita-ot:x="1" align="left">
              <codeph class="+ topic/ph pr-d/codeph ">
                <xsl:attribute name="xtrc" select="concat('codeph:',generate-id(.),'6')"/>
                <xsl:value-of select="concat('static ', @name)"/>
              </codeph>
            </entry>
             <entry class="- topic/entry " colname="c2"  dita-ot:x="2" align="left">
              <codeph class="+ topic/ph pr-d/codeph ">
                <xsl:attribute name="xtrc" select="concat('codeph:',generate-id(.),'7')"/>
                <xsl:call-template name="add-link" >
                  <xsl:with-param name="type" select="'table'" />
                  <xsl:with-param name="href" select="concat('#', @qualified, '/methods_valueOf')" />
                  <xsl:with-param name="text" select="'valueOf'" />
                </xsl:call-template>
                <xsl:text>(java.lang.String name)</xsl:text>
              </codeph>
              <xsl:text>Returns the enum constant of this type with the specified name.</xsl:text>
            </entry>
          </row>
          <row class="- topic/row ">
            <entry class="- topic/entry " colname="c1"  dita-ot:x="1" align="left">
              <codeph class="+ topic/ph pr-d/codeph ">
                <xsl:attribute name="xtrc" select="concat('codeph:',generate-id(.),'8')"/>
                <xsl:value-of select="concat('static ', @name, '[]')"/>
              </codeph>
            </entry>
             <entry class="- topic/entry " colname="c2"  dita-ot:x="2" align="left">
              <codeph class="+ topic/ph pr-d/codeph ">
                <xsl:attribute name="xtrc" select="concat('codeph:',generate-id(.),'9')"/>
                <xsl:call-template name="add-link" >
                  <xsl:with-param name="type" select="'table'" />
                  <xsl:with-param name="href" select="concat('#', @qualified, '/methods_values')" />
                  <xsl:with-param name="text" select="'values'" />
                </xsl:call-template>
                <xsl:text>()</xsl:text>
              </codeph>
              <xsl:text>Returns an array containing the constants of this enum type, in the order they are declared.</xsl:text>
            </entry>
          </row>
        </tbody>
      </tgroup>
    </table>
  </xsl:template>
  <!--
    Enum Method Detail
  -->
  <xsl:template name="add-enum-method-detail">
    <xsl:variable name="class" select="@name"/>
      
    <!--
      Enum valueOf
    -->

    <xsl:variable name="details_valueOf">
      <codeblock class="+ topic/pre pr-d/codeblock ">
        <xsl:attribute name="xtrc" select="concat('codeblock:',generate-id(.),'4')"/>
        <xsl:text>public static </xsl:text>
        <xsl:call-template name="add-class-link">
          <xsl:with-param name="class" select="$class"/>
        </xsl:call-template>
        <xsl:text> valueOf(java.lang.String name)</xsl:text>
      </codeblock>
      <p class="- topic/p ">
       <xsl:text>Returns the enum constant of this type with the specified name. The string must match exactly an identifier used to declare an enum constant in this type. (Extraneous whitespace characters are not permitted.)</xsl:text>
      </p>

       <p class="- topic/p ">
        <b class="+ topic/ph hi-d/b ">
          <xsl:text>Parameters:</xsl:text>
        </b>
      </p>
      <p class="- topic/p ">
        <xsl:text>name - the name of the enum constant to be returned.</xsl:text>
      </p>
      <p class="- topic/p ">
        <b class="+ topic/ph hi-d/b ">  
          <xsl:text>Returns:</xsl:text>
        </b>
      </p>
      <p class="- topic/p ">
        <xsl:text>the enum constant with the specified name</xsl:text>
      </p>
    </xsl:variable>

    <table class="- topic/table " outputclass="enum_methods" id="methods_valueOf">
      <xsl:call-template name="mini-table" >
        <xsl:with-param name="header" select="'valueOf'"/>
        <xsl:with-param name="body" select="$details_valueOf"/>
      </xsl:call-template>
    </table>
    <p class="- topic/p "/>
    <!--
      Enum values
    -->
    <xsl:variable name="details_values">
      <codeblock class="+ topic/pre pr-d/codeblock ">
        <xsl:attribute name="xtrc" select="concat('codeblock:',generate-id(.),'5')"/>
        <xsl:text>public static </xsl:text>
        <xsl:call-template name="add-class-link">
          <xsl:with-param name="class" select="$class"/>
        </xsl:call-template>
        <xsl:text>[] values()</xsl:text>
      </codeblock>
      <p class="- topic/p ">
       <xsl:text>Returns an array containing the constants of this enum type, in the order they are declared. This method may be used to iterate over the constants as follows:</xsl:text>
      </p>

      <codeblock class="+ topic/pre pr-d/codeblock ">
        <xsl:attribute name="xtrc" select="concat('codeblock:',generate-id(.),'6')"/>
        <xsl:value-of select="concat('for (', @name, ' c : ', @name, '.values())')"/>
        <xsl:text>&#10;    System.out.println(c);</xsl:text>
      </codeblock>
      <p class="- topic/p ">
        <b class="+ topic/ph hi-d/b ">  
          <xsl:text>Returns:</xsl:text>
        </b>
      </p>
      <p class="- topic/p ">
        <xsl:text>an array containing the constants of this enum type, in the order they are declared</xsl:text>
      </p>
    </xsl:variable>


    <table class="- topic/table " outputclass="enum_methods" id="methods_values">
      <xsl:call-template name="mini-table" >
        <xsl:with-param name="header" select="'values'"/>
        <xsl:with-param name="body" select="$details_values"/>
      </xsl:call-template>
    </table>
    <p class="- topic/p "/>
  </xsl:template>
</xsl:stylesheet>