<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    
    <xsl:import href="/modules/library-stk/error.xsl"/> 
    
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>Error</h1>
        
        <xsl:call-template name="stk:error.create-message"/>
            
        
        
        <xsl:call-template name="stk:error.create-message">
            <xsl:with-param name="locale" select="'no'"/>
        </xsl:call-template>
    
    
        
    </xsl:template>
    
    
</xsl:stylesheet>