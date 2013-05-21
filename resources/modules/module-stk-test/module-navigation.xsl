<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/navigation.xsl"/> 
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>Navigation</h1>
        
        
        <xsl:call-template name="navigation.get-menuitem-name" />          
        <xsl:call-template name="navigation.create-menu" />          
        <xsl:call-template name="navigation.create-breadcrumbs" />  
        
    </xsl:template>
    
    <xsl:template name="navigation.get-menuitem-name">
        <h2>stk:navigation.get-menuitem-name</h2>
        <xsl:value-of select="stk:navigation.get-menuitem-name(/result/context/resource)"/>
    </xsl:template>
    
    <xsl:template name="navigation.create-menu">
        <h2>stk:navigation.create-menu</h2>
        <xsl:call-template name="stk:navigation.create-menu">
            <xsl:with-param name="menuitems" select="/result/menus/menu/menuitems/menuitem"/>
        </xsl:call-template>
    </xsl:template>
    
    
    
    <xsl:template name="navigation.create-breadcrumbs">
        <h2>stk:navigation.create-breadcrumbs</h2>
        
        <h3>With home</h3>
        <xsl:call-template name="stk:navigation.create-breadcrumbs"/>
        
        <h3>Without home</h3>
        <xsl:call-template name="stk:navigation.create-breadcrumbs">
            <xsl:with-param name="include-home" select="false()"/>
        </xsl:call-template>
    </xsl:template>
    
    
</xsl:stylesheet>