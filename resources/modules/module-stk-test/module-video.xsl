<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/video.xsl"/> 
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>Video</h1>
        
        <h2>stk.video.embed-youtube</h2>
    
        <h3>Video id (full Youtube URL)</h3>
        <xsl:call-template name="stk:video.embed-youtube">
            <xsl:with-param name="video-id" select="'http://www.youtube.com/watch?v=F98e27eYBdU'"/>
        </xsl:call-template>
        
        <h3>Video id (ID only)</h3>
        <xsl:call-template name="stk:video.embed-youtube">
            <xsl:with-param name="video-id" select="'F98e27eYBdU'"/>
        </xsl:call-template>
        
        <h3>Width/height</h3>
        <xsl:call-template name="stk:video.embed-youtube">
            <xsl:with-param name="video-id" select="'F98e27eYBdU'"/>
            <xsl:with-param name="width" select="200"/>
            <xsl:with-param name="height" select="100"/>            
        </xsl:call-template>
        
        <h3>Thumbnail only</h3>
        <xsl:call-template name="stk:video.embed-youtube">
            <xsl:with-param name="video-id" select="'F98e27eYBdU'"/>
            <xsl:with-param name="thumbnail-only" select="true()"/>
        </xsl:call-template>
    
    </xsl:template>
    
</xsl:stylesheet>