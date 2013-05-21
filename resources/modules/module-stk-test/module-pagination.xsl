<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/pagination.xsl"/> 
    
    <xsl:output method="xhtml"/>
    
    <xsl:variable name="contents" select="/result/contents"/>
    
    <xsl:template match="/">
        <h1>Pagination</h1>
        
        <xsl:call-template name="pagination.create-header"/>
        
        <xsl:call-template name="pagination.create-menu"/>
        
        
    
    </xsl:template>
    
    
    <xsl:template name="pagination.create-header">        
        <h2>stk:pagination.create-header</h2>
        <xsl:call-template name="stk:pagination.create-header">
            <xsl:with-param name="contents" select="$contents"/>            
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="pagination.create-menu">        
        <h2>stk:pagination.create-menu</h2>
        <xsl:call-template name="stk:pagination.create-menu">
            <xsl:with-param name="contents" select="$contents"/>            
        </xsl:call-template>
    </xsl:template>
    
    
</xsl:stylesheet>