<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/video.xsl"/> 
    
    <xsl:output method="xhtml"/>
    
    <xsl:variable name="languages" select="'en', 'no'"/>
    
    <xsl:variable name="phrases" xmlns="">
        <phrase>stk.accessibility.skip-to-main-content</phrase>
        <phrase>stk.accessibility.text-resizing-guidance</phrase>
        <phrase>stk.error.403-heading</phrase>
        <phrase>stk.error.403-description</phrase>
        <phrase>stk.error.404-heading</phrase>
        <phrase>stk.error.404-description</phrase>
        <phrase>stk.error.500-heading</phrase>
        <phrase>stk.error.500-description</phrase>
        <phrase>stk.error.504-heading</phrase>
        <phrase>stk.error.504-description</phrase>
        <phrase>stk.error.505-heading</phrase>
        <phrase>stk.error.505-description</phrase>
        <phrase>stk.error.506-heading</phrase>
        <phrase>stk.error.506-description</phrase>
        <phrase>stk.error.exception-message</phrase>
        <phrase>stk.error.url</phrase>
        <phrase>stk.file.icon</phrase>
        <phrase>stk.file.html</phrase>
        <phrase>stk.file.powerpoint</phrase>
        <phrase>stk.file.image</phrase>
        <phrase>stk.file.document</phrase>
        <phrase>stk.file.pdf</phrase>
        <phrase>stk.file.video</phrase>
        <phrase>stk.file.excel</phrase>
        <phrase>stk.file.xml</phrase>
        <phrase>stk.file.text</phrase>
        <phrase>stk.file.zip</phrase>
        <phrase>stk.file.file</phrase>
        <phrase>stk.pagination.header-text</phrase>
        <phrase>stk.pagination.first-page</phrase>
        <phrase>stk.pagination.previous-page</phrase>
        <phrase>stk.pagination.next-page</phrase>
        <phrase>stk.pagination.last-page</phrase>
        <phrase>stk.pagination.page</phrase>
        <phrase>stk.time.yesterday</phrase>
        <phrase>stk.time.at</phrase>
        <phrase>stk.time.hours-ago</phrase>
        <phrase>stk.time.about-an-hour-ago</phrase>
        <phrase>stk.time.minutes-ago</phrase>
        <phrase>stk.time.about-a-minute-ago</phrase>
        <phrase>stk.time.less-than-a-minute-ago</phrase>
        <phrase>stk.time.just-now</phrase>
        <phrase>stk.navigation.breadcrumbs.home</phrase>
        <phrase>stk.pagination.show-#count-more</phrase>
        <phrase>stk.pagination.showing-#count-of-#totalcount</phrase>
       
        
    </xsl:variable>
    
    <xsl:template match="/">
        <h1>Localization</h1>
        
        
        
        <ul>
            <xsl:apply-templates select="$phrases/phrase"/>
        </ul>
        
    
    </xsl:template>
    
    
    
    <xsl:template match="phrase">
        <xsl:variable name="phrase" select="."/>
        <li>
            <h2>
                <xsl:value-of select="."/>
            </h2>
            <ol>
                <xsl:for-each select="$languages">
                    <xsl:variable name="language" select="."/>
                    <li>
                        <xsl:if test="contains(portal:localize($phrase, (), $language), 'NOT TRANSLATED')">
                            <xsl:attribute name="class" select="'fail'"/>
                        </xsl:if>
                        <xsl:value-of select="$language"/>
                        <xsl:text>: </xsl:text>
                        <xsl:value-of select="portal:localize($phrase, (), $language)"/>
                    </li>
                </xsl:for-each>
            </ol>
        </li>
    </xsl:template>
    
    
</xsl:stylesheet>