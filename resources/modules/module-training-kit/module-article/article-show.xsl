<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
  xmlns="http://www.w3.org/1999/xhtml" version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:portal="http://www.enonic.com/cms/xslt/portal"
  xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
  
  <xsl:import href="/modules/library-stk/stk-variables.xsl"/>  
  <xsl:import href="/modules/library-stk/html.xsl"/> 
  <xsl:import href="/modules/library-stk/image.xsl"/>   
  <xsl:import href="/modules/library-stk/text.xsl"/> 
  <xsl:import href="/modules/library-stk/time.xsl"/>     
  
  <xsl:output method="xhtml"/>

  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="/result/article/contents/content">
          <xsl:apply-templates select="/result/article/contents/content"/>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:value-of select="portal:localize('article.no-article')"/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="content">
    <article>
      <h1>
        <xsl:value-of select="title"/>
      </h1>
      
      <xsl:if test="/result/article/contents/relatedcontents/content[@key = current()/contentdata/image/image/@key]">
        <xsl:call-template name="stk:image.create">
          <xsl:with-param name="image" select="/result/article/contents/relatedcontents/content[@key = current()/contentdata/image[1]/image/@key]"/>
          <xsl:with-param name="size" select="if ($stk:device-class = 'mobile') then 'full' else 'list'"/>
          <xsl:with-param name="class" select="'intro-image'"/>
        </xsl:call-template>
      </xsl:if>
      
      <div class="byline">
        <xsl:call-template name="stk:time.format-date">
          <xsl:with-param name="date" select="@publishfrom"/>
        </xsl:call-template>
      </div>
      
      <xsl:if test="normalize-space(contentdata/preface)">
        <p class="preface">          
          <xsl:call-template name="stk:text.process">
            <xsl:with-param name="text" select="contentdata/preface"/>
          </xsl:call-template>
        </p>
      </xsl:if>
      <xsl:call-template name="stk:html.process">
        <xsl:with-param name="document" select="contentdata/text"/>
      </xsl:call-template>
      
    </article>    
  </xsl:template>

</xsl:stylesheet>
