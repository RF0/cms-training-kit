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
        
        <xsl:call-template name="stk:html.process">
            <xsl:with-param name="document" select="/result/context/window/portlet/document"/>
        </xsl:call-template>
        
        
        
        
    </xsl:template>
    
   
    
</xsl:stylesheet>