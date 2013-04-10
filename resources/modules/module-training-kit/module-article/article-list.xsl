<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
  xmlns="http://www.w3.org/1999/xhtml" version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:portal="http://www.enonic.com/cms/xslt/portal"
  xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
  
  <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
  <xsl:import href="/modules/library-stk/image.xsl"/>  
  <xsl:import href="/modules/library-stk/pagination.xsl"/>
  <xsl:import href="/modules/library-stk/time.xsl"/>  
  <xsl:import href="/modules/library-stk/text.xsl"/>  
  
  <xsl:output method="xhtml"/>
    
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="/result/articles/contents/content">
        <xsl:call-template name="stk:pagination.create-header">
          <xsl:with-param name="contents" select="/result/articles/contents"/>
        </xsl:call-template>
        <xsl:if test="/result/articles/contents/content">
          <ol id="article-list">
            <xsl:apply-templates select="/result/articles/contents/content"/>
          </ol>
        </xsl:if>
        <xsl:call-template name="stk:pagination.create-menu">
          <xsl:with-param name="contents" select="/result/articles/contents"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:value-of select="portal:localize('article.no-articles')"/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="content">
    <li>
      <xsl:if test="$stk:device-class != 'mobile'">
        <xsl:call-template name="image">
          <xsl:with-param name="size" select="'list'"/>
        </xsl:call-template>
      </xsl:if>
      <h2>
        <a href="{portal:createContentUrl(@key,())}">
          <xsl:value-of select="contentdata/heading"/>
        </a>
      </h2>
      <xsl:if test="$stk:device-class = 'mobile'">
        <xsl:call-template name="image">
          <xsl:with-param name="size" select="'wide'"/>
        </xsl:call-template>
      </xsl:if>
      <div class="byline">
        <xsl:call-template name="stk:time.format-date">
          <xsl:with-param name="date" select="@publishfrom"/>
        </xsl:call-template>
      </div>
      <xsl:if test="normalize-space(contentdata/preface)">
        <div class="preface">
          <xsl:value-of select="contentdata/preface"/>
        </div>
      </xsl:if>
      
      <a href="{portal:createContentUrl(@key,())}" title="{title}">
        <xsl:value-of select="portal:localize('article.read-more')"/>
      </a>
    </li>
  </xsl:template>
  
  <xsl:template name="image">
    <xsl:param name="size"/>
    <xsl:if test="/result/articles/contents/relatedcontents/content[@key = current()/contentdata/image[1]/image/@key]">
      <a href="{portal:createContentUrl(@key,())}" title="{title}">
        <xsl:call-template name="stk:image.create">
          <xsl:with-param name="image" select="/result/articles/contents/relatedcontents/content[@key = current()/contentdata/image[1]/image/@key]"/>
          <xsl:with-param name="size" select="$size"/>
        </xsl:call-template>
      </a>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>
