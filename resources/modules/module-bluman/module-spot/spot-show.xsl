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
    <div id="spot-show">
        <xsl:choose>
          <xsl:when test="/result/contents/content">
            <div id="spot">
              <xsl:apply-templates select="/result/contents/content"/>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <p class="clear">
              <xsl:value-of select="portal:localize('theme-bluman.no-spot')"/>
            </p>
          </xsl:otherwise>
        </xsl:choose>
     </div>
  </xsl:template>

  <xsl:template match="content">
    
    <xsl:if test="$stk:device-class = 'mobile'">
      <xsl:call-template name="related-content">
      <xsl:with-param name="size" select="'full'"/>
      <xsl:with-param name="start" select="1"/>
      </xsl:call-template>
    </xsl:if>
    <h1>
      <xsl:value-of select="contentdata/spot"/>,
      <span class="capitalize"><xsl:value-of select="location/site/contentlocation/@menuitemname" /> </span>
    </h1>
    <xsl:call-template name="stk:html.process">
      <xsl:with-param name="document" select="contentdata/description"/>
    </xsl:call-template>
    
  </xsl:template>

  <xsl:template name="related-content">
    <xsl:param name="size"/>
    <xsl:param name="start" select="1"/>
    <xsl:if test="/result/contents/relatedcontents/content[@key = current()/contentdata/image[position() >= $start]/image/@key] or contentdata/link/url != '' or /result/contents/relatedcontents/content[@key = current()/contentdata/articles/content/@key] or /result/contents/relatedcontents/content[@key = current()/contentdata/file/file/file/@key]">
      <div id="slider">
      <ul class="spot image list">

        <xsl:if test="/result/contents/relatedcontents/content[@key = current()/contentdata/image[position() >= $start]/image/@key]">
          <xsl:for-each select="contentdata/image[position() >= $start and image/@key = /result/contents/relatedcontents/content/@key]">
            <li>
              <xsl:if test="position() != 1">
                <xsl:attribute name="style">display:none;</xsl:attribute>
              </xsl:if>
              <!--<xsl:call-template name="image.display-image">
                <xsl:with-param name="image" select="/result/contents/relatedcontents/content[@key = current()/image/@key]"/>
                <xsl:with-param name="size" select="$size"/>
                </xsl:call-template>-->
             <!-- <img src="{portal:createImageUrl(/result/contents/relatedcontents/content[@key = current()/image/@key]/@key, 'scaleblock(320, 250)')}" height="250" width="320"/>
              -->
              <xsl:call-template name="stk:image.create">
                <xsl:with-param name="image" select="/result/contents/relatedcontents/content[@key = current()/image/@key]"/>
                <xsl:with-param name="scaling" select="'scaleblock(320,250)'"/>
              </xsl:call-template>
              
              <span class="image-text"><xsl:value-of select="image_text"/></span>
            </li>
          </xsl:for-each>
        </xsl:if>
      </ul>
        <span class="position">
          <xsl:for-each select="contentdata/image[position() >= $start and image/@key = /result/contents/relatedcontents/content/@key]">
            <em>
             <xsl:if test="position() = 1">
              <xsl:attribute name="class">on</xsl:attribute>
            </xsl:if>•</em>
          </xsl:for-each>
        </span>
      </div>
    </xsl:if> 
  </xsl:template>

</xsl:stylesheet>