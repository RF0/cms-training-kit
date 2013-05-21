<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/video.xsl"/> 
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>Localization</h1>
        <xsl:variable name="languages" select="'en', 'no'"/>
        
        <xsl:variable name="phrases" as="element()*">
            <phrase>stk.accessibility.skip-to-main-content</phrase>
            <phrase>stk.accessibility.text-resizing-guidance</phrase>
        </xsl:variable>
        
        <ul>
            <xsl:apply-templates select="$phrases"/>
            <!--<xsl:for-each select="$phrases">
                <xsl:variable name="phrase" select="."/>
                <h2>
                    <xsl:value-of select="$phrase"/>
                </h2>
                <xsl:for-each select="$languages">
                    <xsl:variable name="language" select="."/>
                    <xsl:text>: </xsl:text>
                    <xsl:value-of select="portal:localize($phrase)"/>
                </xsl:for-each>
            </xsl:for-each>-->
        </ul>
        
    
    </xsl:template>
    
    <xsl:template match="phrase">
        <li>
            <h2>
                <xsl:value-of select="."/>
            </h2>
        </li>
    </xsl:template>
    
</xsl:stylesheet>