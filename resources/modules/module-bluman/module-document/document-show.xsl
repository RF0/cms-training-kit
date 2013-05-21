<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0" xmlns="http://www.w3.org/1999/xhtml"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"    
  xmlns:portal="http://www.enonic.com/cms/xslt/portal"
  xmlns:stk="http://www.enonic.com/cms/xslt/stk">
  
  <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
  <xsl:import href="/modules/library-stk/html.xsl"/>
  
  <xsl:import href="/modules/library-stk/image.xsl"/>
  
  <xsl:output method="xhtml"/>

  <xsl:template match="/">
    <xsl:apply-templates select="/result/document/contents/content"/>
  </xsl:template>

  <xsl:template match="content">
    <h1>
      <xsl:value-of select="title"/>
    </h1>
    <xsl:call-template name="stk:html.process">
      <xsl:with-param name="document" select="contentdata/text"/>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
