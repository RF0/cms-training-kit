<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/json.xsl"/> 
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>JSON</h1>
        
        <h2>stk:analytics.google</h2>
    
        <xsl:call-template name="json.encode-string"/>
        
    
    </xsl:template>
    
    <xsl:template name="json.encode-string">
        <xsl:variable name="string-1" select="'tors bror'"/>
        <xsl:value-of select="stk:json.encode-string($string-1)"/>
    </xsl:template>
    
</xsl:stylesheet>