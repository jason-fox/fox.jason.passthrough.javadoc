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
               <xsl:text>Modifier and Type</xsl:text>
            </entry>
            <entry class=" topic/entry " colname="c2" dita-ot:x="2" align="left">
               <xsl:text>Method and Description</xsl:text>
            </entry>
          </row>
        </thead>
        <tbody class=" topic/tbody ">
          <xsl:for-each select="method">
            <xsl:sort select="@name"/>
            <xsl:variable name="method" select="@name"/>
            <row class=" topic/row ">
              <entry class=" topic/entry " colname="c1"  dita-ot:x="1" align="left">
                <codeph class=" pr-d/codeph ">
                  <xsl:value-of select="dita-ot:addZeroWidthSpaces(child::return/@qualified)"/>
                  <xsl:apply-templates select="child::return/generic"/>
                </codeph>
              </entry>
               <entry class=" topic/entry " colname="c2"  dita-ot:x="2" align="left">
                <codeph class=" pr-d/codeph ">
                  <xsl:call-template name="add-link" >
                    <xsl:with-param name="type" select="'table'" />
                    <xsl:with-param name="href">
                      <xsl:value-of select="concat('#', parent::*/@qualified, '/methods_', $method)"/>
                      <xsl:if test="count(../method[@name=$method])&gt;1">
                        <xsl:value-of select="count(following-sibling::method[@name=$method])"/>
                      </xsl:if>
                    </xsl:with-param>
                    <xsl:with-param name="text" select="$method" />
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
  <xsl:template name="add-inherited-method-summary">
    <xsl:variable name="extends">
      <xsl:value-of select="class/@qualified"/>
    </xsl:variable>

    <xsl:choose>
      <xsl:when test="//package/class[@qualified=$extends]">
        <xsl:call-template name="inheritance-method-summary">
          <xsl:with-param name="extends" select = "//package/class[@qualified=$extends]/@qualified" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="inheritance-java-lang" >
          <xsl:with-param name="extends" select = "$extends" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--
    List methods from inherited classes
  -->
  <xsl:template name="inheritance-method-summary">
    <xsl:param name = "extends" />
      
    <xsl:variable name="inherited_methods">
      <xsl:text>Methods inherited from class </xsl:text>
      <xsl:value-of select="replace(@qualified,'\..*$','.')"/>
      <xsl:call-template name="add-link" >
        <xsl:with-param name="type" select="'topic'" />
        <xsl:with-param name="href" select="concat('#', //package/class[@qualified=$extends]/@qualified)" />
        <xsl:with-param name="text" select="//package/class[@qualified=$extends]/@name" />
      </xsl:call-template>
    </xsl:variable>

    <xsl:variable name="inherited_methods_details">
      <xsl:for-each select="//package/class[@qualified=$extends]/method">
        <xsl:sort select="@name"/>
        <xsl:variable name="method" select="@name"/>
        <codeph class=" pr-d/codeph ">
          <xsl:call-template name="add-link" >
            <xsl:with-param name="type" select="'table'" />
            <xsl:with-param name="href">
              <xsl:value-of select="concat('#', $extends,'/methods_', $method)"/>
              <xsl:if test="count(../method[@name=$method])&gt;1">
                <xsl:value-of select="count(following-sibling::method[@name=$method])"/>
              </xsl:if>
            </xsl:with-param>
            <xsl:with-param name="text" select="$method" />
          </xsl:call-template>
        </codeph>
        <xsl:if test="position() != last()">
          <xsl:text>, </xsl:text>
        </xsl:if>
      </xsl:for-each>
    </xsl:variable>

    <p class="- topic/p "/>
    <table class=" topic/table " outputclass="method_details">
      <xsl:call-template name="mini-table" >
        <xsl:with-param name="header" select="$inherited_methods"/>
        <xsl:with-param name="body" select="$inherited_methods_details"/>
      </xsl:call-template>
    </table>

    <xsl:variable name="reextends">
      <xsl:value-of select="//package/class[@qualified=$extends]/class/@qualified"/>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="//package/class[@qualified=$reextends]">
        <xsl:call-template name="inheritance-method-summary" >
          <xsl:with-param name="extends" select = "//package/class[@qualified=$reextends]/@qualified" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="inheritance-java-lang" >
          <xsl:with-param name="extends" select = "$reextends" />
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--
      Method Details
  -->
  <xsl:template match="method">
    <xsl:variable name="method" select="@name"/>
    <xsl:variable name="method_details">
      <codeblock class=" pr-d/codeblock ">
        <xsl:value-of select="concat(@scope, ' ')"/>
        <xsl:if test="@static='true'">
          <xsl:text>static </xsl:text>
        </xsl:if>
        <xsl:variable name="class" select="child::return/@qualified"/>
        <xsl:call-template name="add-class-link">
          <xsl:with-param name="class" select="$class"/>
        </xsl:call-template>
        <xsl:apply-templates select="child::return/generic"/>
        <xsl:value-of select="concat(' ', $method)"/>
        <xsl:call-template name="add-signature"/>
      </codeblock>
      <p class="- topic/p ">
        <xsl:value-of select="comment"/>
      </p>
      <xsl:call-template name="parameter-description"/>
      <xsl:call-template name="return-description"/>
    </xsl:variable>

    <table class=" topic/table " outputclass="method_details">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('methods_', $method)"/>
        <xsl:if test="count(../method[@name=$method])&gt;1">
          <xsl:value-of select="count(following-sibling::method[@name=$method])"/>
        </xsl:if>
      </xsl:attribute>
      <xsl:call-template name="mini-table" >
        <xsl:with-param name="header">
          <xsl:value-of select="$method"/>
        </xsl:with-param>
        <xsl:with-param name="body" select="$method_details"/>
      </xsl:call-template>
    </table>
    <p class="- topic/p "/>
  </xsl:template>

  <!--
    Create a method signature based on the parameter set
  -->
  <xsl:template name="add-signature">
    <xsl:text>(</xsl:text>
    <xsl:for-each select="parameter">
      <xsl:variable name="class" select="type/@qualified"/>
      <xsl:call-template name="add-class-link">
        <xsl:with-param name="class" select="$class"/>
      </xsl:call-template>
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
    <xsl:variable name="class" select="@qualified"/>
    <xsl:call-template name="add-class-link">
      <xsl:with-param name="class" select="$class"/>
    </xsl:call-template>
    <xsl:apply-templates select="generic"/>
    <xsl:text>&gt;&#8203;</xsl:text>
  </xsl:template>


    <!---
-->
  <xsl:template name="add-class-link">
    <xsl:param name = "class" />
    <xsl:choose>
      <xsl:when test="//package/class[@qualified=$class]">
        <xsl:call-template name="add-link" >
          <xsl:with-param name="type" select="'topic'" />
          <xsl:with-param name="href" select="concat('#', $class)"/>
          <xsl:with-param name="text" select="replace($class,'^.*\.','')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="//package/interface[@qualified=$class]">
        <xsl:call-template name="add-link" >
          <xsl:with-param name="type" select="'topic'" />
          <xsl:with-param name="href" select="concat('#', $class)"/>
          <xsl:with-param name="text" select="replace($class,'^.*\.','')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="//package/enum[@qualified=$class]">
        <xsl:call-template name="add-link" >
          <xsl:with-param name="type" select="'topic'" />
          <xsl:with-param name="href" select="concat('#', $class)"/>
          <xsl:with-param name="text" select="replace($class,'^.*\.','')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="$class">
         <xsl:value-of select="dita-ot:addZeroWidthSpaces($class)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>????</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:function name="dita-ot:addZeroWidthSpaces">
    <xsl:param name="text" as="xs:string"/>
    <xsl:value-of select="replace($text,'\.','.&#8203;')"/>
  </xsl:function>

</xsl:stylesheet>