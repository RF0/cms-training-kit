<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"    
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    <xsl:import href="page-includes.xsl"/>
    
    <!-- page type -->
    <!-- For multiple layouts on one site. Various layouts can be configured in theme.xml, each with a different 'name' attribute on the 'layout' element. -->
    <xsl:param name="layout" as="xs:string" select="'default'"/>

    
    <xsl:param name="r1-g1-c1">
        <type>region</type>
    </xsl:param>
    <xsl:param name="r1-g2-c1">
        <type>region</type>
    </xsl:param>
    <xsl:param name="r1-g2-c2">
        <type>region</type>
    </xsl:param>
    <xsl:param name="r1-g2-c3">
        <type>region</type>
    </xsl:param>
    <xsl:param name="r1-g2-c4">
        <type>region</type>
    </xsl:param>
    <xsl:param name="r1-g2-c5">
        <type>region</type>
    </xsl:param>
    
    
</xsl:stylesheet>
