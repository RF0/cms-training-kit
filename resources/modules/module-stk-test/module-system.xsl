<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/> 
    <xsl:import href="/modules/library-stk/system.xsl"/>
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>System</h1>
        
        
        <xsl:call-template name="system.get-config-param" />          
        <xsl:call-template name="system.check-config" />          
        
    </xsl:template>
    
    <xsl:template name="system.get-config-param">
        <h2>stk:system.get-config-param</h2>
        <xsl:value-of select="stk:system.get-config-param('meta-generator', $stk:path)"/>
    </xsl:template>
    
    <xsl:template name="system.check-config">
        <h2>stk:system.check-config</h2>
        <xsl:copy-of select="stk:system.check-config()"/>
        
    </xsl:template>
    
    
</xsl:stylesheet>