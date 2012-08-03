<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
    <xsl:import href="/modules/library-stk/pagination.xsl"/>
    <xsl:import href="/modules/library-stk/video.xsl"/>  
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="/result/videos/contents/content">
                <xsl:call-template name="stk:pagination.create-header">
                    <xsl:with-param name="contents" select="/result/videos/contents"/>
                </xsl:call-template>
                <ol>                    
                    <xsl:apply-templates select="/result/videos/contents/content"/>
                </ol>
                <xsl:call-template name="stk:pagination.create-menu">
                    <xsl:with-param name="contents" select="/result/videos/contents"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:value-of select="portal:localize('No-videos')"/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="content">
        <li>
            <h2>
                <xsl:value-of select="title"/>
            </h2>
            <p>
                <xsl:value-of select="contentdata/description"/>
            </p>
            <xsl:call-template name="stk:video.embed-youtube">
                <xsl:with-param name="video-id" select="contentdata/video-id"/>
            </xsl:call-template>
        </li>
    </xsl:template>
    
</xsl:stylesheet>
