<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/text.xsl"/> 
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>Text</h1>
        
        
        <xsl:call-template name="text.process" />          
        <xsl:call-template name="text.crop" />          
        <xsl:call-template name="text.capitalize" />  
        
    </xsl:template>
    
    <xsl:template name="text.process">
        <h2>stk:text.process</h2>
        <xsl:call-template name="stk:text.process">
            <xsl:with-param name="text" select="'This is processed?'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="text.crop">
        <h2>stk:text.crop</h2>
        <xsl:value-of select="stk:text.crop('This is a long text', 11)"/>
    </xsl:template>
    
    <xsl:template name="text.capitalize">
        <h2>stk:text.capitalize</h2>
        <xsl:value-of select="stk:text.capitalize('capitalized?')"/>
    </xsl:template>
    
    
    
</xsl:stylesheet>