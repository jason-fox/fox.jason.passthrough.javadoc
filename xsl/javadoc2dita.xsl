<?xml version="1.0" encoding="UTF-8"?>
<!--
  This file is part of the DITA Open Toolkit project.
  See the accompanying license.txt file for applicable licenses.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:dita-ot="http://dita-ot.sourceforge.net/ns/201007/dita-ot"
                xmlns:ditaarch="http://dita.oasis-open.org/architecture/2005/"
                version="2.0">
  
  <xsl:param name="output.dir.uri"/>

  <xsl:function name="dita-ot:addZeroWidthSpaces">
    <xsl:param name="text" as="xs:string"/>
    <xsl:value-of select="replace($text,'\.','.&#8203;')"/>
  </xsl:function>

  <xsl:template name="add-comment">
    <xsl:if test="comment">
      <lines class=" topic/lines "><xsl:value-of select="comment"/></lines>
    </xsl:if>
  </xsl:template>

  <xsl:template name="add-parameters">
    <xsl:text>(</xsl:text>
    <xsl:for-each select="parameter">
      <xsl:value-of select="replace(type/@qualified,'^.*\.','')"/>
      <xsl:value-of select="type/@dimension"/>
      <xsl:value-of select="concat(' ', @name)"/>
      <xsl:apply-templates select="type/generic"/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>)</xsl:text>
  </xsl:template>

  <xsl:template name="parameter-details">
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

  <xsl:template name="return-details">
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

  <xsl:template name="add-package-summary">
    <li class=" topic/li ">
      <xref class="- topic/xref " format="dita" scope="local">
        <xsl:attribute name="href">
          <xsl:value-of select="concat('#', @name)"/>
        </xsl:attribute>
        <xsl:value-of select="@name"/>
      </xref>
      <xsl:if test="comment">
        <xsl:value-of select="concat (' - ',substring-before(comment,'.'),'.')"/>
      </xsl:if>
    </li>
  </xsl:template>

  <xsl:template name="add-summary">
    <li class=" topic/li ">
      <xref class="- topic/xref " format="dita" scope="local">
        <xsl:attribute name="href">
          <xsl:value-of select="concat('#', parent::*/@name, '.', @name)"/>
        </xsl:attribute>
        <xsl:value-of select="@name"/>
      </xref>
      <xsl:if test="comment">
        <xsl:value-of select="concat (' - ',substring-before(comment,'.'),'.')"/>
      </xsl:if>
    </li>
  </xsl:template>

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
                  <xref class="- topic/xref " format="dita">
                    <xsl:attribute name="href">
                      <xsl:value-of select="concat('#', parent::*/@qualified, '/constructors_', @name)"/>
                    </xsl:attribute>
                    <xsl:value-of select="@name"/>
                  </xref>
                  <xsl:call-template name="add-parameters"/>
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

  <xsl:template name="add-constant-summary">
    <ul class=" topic/ul ">
      <xsl:for-each select="constant">
        <xsl:sort select="@name"/>
           
        <li class=" topic/li ">
          <xref class="- topic/xref " format="dita">
            <xsl:attribute name="href">
              <xsl:value-of select="concat('#', parent::*/@qualified, '/enums_', @name)"/>
            </xsl:attribute>
            <xsl:value-of select="@name"/>
          </xref>
          <xsl:if test="comment">
            <xsl:value-of select="concat (' - ',substring-before(comment,'.'),'.')"/>
          </xsl:if>
        </li>
     </xsl:for-each>
    </ul>

  </xsl:template>

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
                  <xsl:value-of select="dita-ot:addZeroWidthSpaces(return/@qualified)"/>
                  <xsl:apply-templates select="return/generic"/>
                </codeph>
              </entry>
               <entry class=" topic/entry " colname="c2"  dita-ot:x="2" align="left">
                <codeph class=" pr-d/codeph ">
                  <xref class="- topic/xref " format="dita">
                    <xsl:attribute name="href">
                      <xsl:value-of select="concat('#', parent::*/@qualified, '/methods_', @name)"/>
                    </xsl:attribute>
                    <xsl:value-of select="@name"/>
                  </xref>
                  <xsl:call-template name="add-parameters"/>
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
        <xsl:call-template name="add-comment"/>
        <xsl:if test="class">
          <section class="- topic/section " outputclass="enums_summary">
            <title class="- topic/title " >Class Summary</title>
            <ul class=" topic/ul ">
            <xsl:for-each select="class">
              <xsl:sort select="@name"/>
              <xsl:call-template name="add-summary"/>
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
              <xsl:call-template name="add-summary"/>
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
              <xsl:call-template name="add-summary"/>
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
        <xsl:call-template name="add-comment"/>
        <!-- Class Summary -->
        <xsl:if test="constructor">
           <section class="- topic/section " outputclass="contructors_summary">
            <title class="- topic/title " >Constructor Summary</title>
            <xsl:call-template name="add-constructor-summary"/>
          </section>
        </xsl:if>
        <xsl:if test="method">
           <section class="- topic/section " outputclass="methods_summary">
            <title class="- topic/title " >Method Summary</title>
            <xsl:call-template name="add-method-summary"/>
          </section>
        </xsl:if>
     
        <!-- Class Details -->
        <xsl:if test="constructor">
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


  <xsl:template match="interface">
    <topic domains="(topic abbrev-d) a(props deliveryTarget) (topic equation-d) (topic hazard-d) (topic hi-d) (topic indexing-d) (topic markup-d) (topic mathml-d) (topic pr-d) (topic relmgmt-d) (topic sw-d) (topic svg-d) (topic ui-d) (topic ut-d) (topic markup-d xml-d)" xmlns:dita="http://dita-ot.sourceforge.net/ns/201007/dita-ot" class="- topic/topic " ditaarch:DITAArchVersion="1.3" props="javadoc">
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
      <body class="- topic/body ">
        <codeblock class=" pr-d/codeblock ">
          <xsl:value-of select="concat(@scope, ' interface ')"/>
          <b class=" hi-d/b "><xsl:value-of select="@name"/></b>
        </codeblock>
        <xsl:call-template name="add-comment"/>
      
        <!-- Interface Summary and details -->
        <xsl:if test="method">
          <section class="- topic/section " outputclass="methods_summary">
            <title class="- topic/title " >Method Summary</title>
            <xsl:call-template name="add-method-summary"/>
          </section>
        </xsl:if>
     
        <xsl:if test="method">
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
      <body class="- topic/body ">
        <codeblock class=" pr-d/codeblock ">
          <xsl:value-of select="concat(@scope, ' enum ')"/>
          <b class=" hi-d/b "><xsl:value-of select="@name"/></b>
          <xsl:text> extends </xsl:text>
          <xsl:value-of select="class/@qualified"/>
          <xsl:text>&lt;</xsl:text>
          <xsl:value-of select="replace(class/generic/@qualified,'^.*\.','')"/>
          <xsl:text>&gt;</xsl:text>
        </codeblock>
        <xsl:call-template name="add-comment"/>
        <xsl:if test="constant">
           <section class="- topic/section " outputclass="constants_summary">
            <title class="- topic/title " >Enum constants</title>
            <xsl:call-template name="add-constant-summary"/>
          </section>
        </xsl:if>
        <xsl:if test="method">
          <section class="- topic/section " outputclass="methods_summary">
            <title class="- topic/title " >Method Summary</title>
            <xsl:call-template name="add-method-summary"/>
          </section>
        </xsl:if>
      
        <xsl:if test="constant">
          <section class="- topic/section " outputclass="constants">
            <xsl:attribute name="id">
              <xsl:value-of select="concat(@qualified, '_constants')"/>
            </xsl:attribute>
            <title class="- topic/title " >Enum Constant Detail</title>
            <xsl:apply-templates select="constant">
              <xsl:sort select="@name" />
            </xsl:apply-templates>
          </section>
           
        </xsl:if>
        <xsl:if test="method">
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

  <xsl:template match="constructor">
    <table class=" topic/table " outputclass="constructor_details">
        <xsl:attribute name="id">
          <xsl:value-of select="concat('constructors_',@name)"/>
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
                   <xsl:call-template name="add-parameters"/>
                </codeph>
                <p class="- topic/p ">
                  <xsl:value-of select="comment"/>
                </p>
                <xsl:call-template name="parameter-details"/>
              </entry>
            </row>
          </tbody>
        </tgroup>
      </table>
    <p class="- topic/p "/>
  </xsl:template>

  <xsl:template match="method">
      <table class=" topic/table " outputclass="method_details">
        <xsl:attribute name="id">
          <xsl:value-of select="concat('methods_',@name)"/>
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
                  <xsl:value-of select="replace(return/@qualified,'^.*\.','')"/>
                  <xsl:value-of select="concat(' ', @name)"/>
                  <xsl:call-template name="add-parameters"/>
                </codeblock>
                <p class="- topic/p ">
                  <xsl:value-of select="comment"/>
                </p>
                <xsl:call-template name="parameter-details"/>
                <xsl:call-template name="return-details"/>
              </entry>
            </row>
          </tbody>
        </tgroup>
      </table>
    <p class="- topic/p "/>
  </xsl:template>

  <xsl:template match="constant">
    <table class=" topic/table " outputclass="enum_details">
        <xsl:attribute name="id">
          <xsl:value-of select="concat('enums_',@name)"/>
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
                  <xsl:text>public static final </xsl:text>
                
                  <xsl:value-of select="replace(class/generic/@qualified,'^.*\.','')"/>
                  <xsl:value-of select="concat(' ', @name)"/>
                </codeblock>
                <p class="- topic/p ">
                  <xsl:value-of select="comment"/>
                </p>
              </entry>
            </row>
          </tbody>
        </tgroup>
      </table>
    <p class="- topic/p "/>
  </xsl:template>
  <xsl:template match="generic">
    <xsl:text>&#8203;&lt;</xsl:text>
    <xsl:value-of select="replace(@qualified,'^.*\.','')"/>
    <xsl:apply-templates select="generic"/>
    <xsl:text>&gt;&#8203;</xsl:text>
  </xsl:template>
</xsl:stylesheet>