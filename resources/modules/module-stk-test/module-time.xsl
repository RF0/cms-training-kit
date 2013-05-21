<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/time.xsl"/> 
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>Time</h1>
        
    
        <xsl:call-template name="time.get-timezone" />        
        <xsl:call-template name="time.format-date" />        
        <xsl:call-template name="time.format-time" />
    
    </xsl:template>
    
    
    <xsl:template name="time.get-timezone">
        <h2>stk:time.get-timezone</h2>
        <xsl:value-of select="stk:time.get-timezone()"/>
    </xsl:template>
    
    <xsl:template name="time.format-date">
        <h2>stk:time.format-date</h2>
        <xsl:call-template name="stk:time.format-date">
            <xsl:with-param name="date" select="current-date()"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="time.format-time">
        <h2>stk:time.format-time</h2>
        <xsl:call-template name="stk:time.format-time">
            <xsl:with-param name="time" select="current-time()"/>
        </xsl:call-template>
    </xsl:template>
    
    
</xsl:stylesheet>