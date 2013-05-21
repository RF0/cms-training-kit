<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/image.xsl"/> 
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>Image</h1>
        
        
        
        <xsl:call-template name="stk:image.create">
            <xsl:with-param name="image" select="/result/contents/content[1]"/>
            <xsl:with-param name="region-width" select="200"/>
            <xsl:with-param name="size" select="'list'"/>
            <xsl:with-param name="format" select="'png'"/>
        </xsl:call-template>
        
    
    </xsl:template>
    
</xsl:stylesheet>