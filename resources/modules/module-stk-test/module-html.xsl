<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/html.xsl"/> 
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>HTML</h1>
        
    
        <xsl:call-template name="html.process" />
        
        <xsl:call-template name="html.process-url" />
    
    </xsl:template>
    
    <xsl:template name="html.process">
        
        <h2>stk:html.process</h2>
        <xsl:call-template name="stk:html.process">
            <xsl:with-param name="document" select="/result/contents/content/contentdata/text"/>
        </xsl:call-template>
        
        
    </xsl:template>
    
    <xsl:template name="html.process-url">
        
        <h2>stk:html.process-url</h2>
        
        <xsl:value-of select="stk:html.process-url('page://28')"/>
        
        <xsl:value-of select="stk:html.process-url('content://28')"/>
        
        <xsl:value-of select="stk:html.process-url('attachment://28')"/>
        
    </xsl:template>
    
</xsl:stylesheet>