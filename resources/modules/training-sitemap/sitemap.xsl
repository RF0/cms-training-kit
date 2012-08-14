<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
    <xsl:import href="/modules/library-stk/menu.xsl"/>
    
    <xsl:output method="xhtml"/>    

    <xsl:variable name="menu" as="element()*" select="/result/menus/menu/menuitems/menuitem"/>
    <xsl:variable name="number-of-columns" select="floor($stk:region-width div 200)"/>
    <xsl:variable name="margin" select="20"/>
    <xsl:variable name="column-width" select="floor(($stk:region-width - ($margin * ($number-of-columns - 1))) div $number-of-columns)"/>

    <xsl:template match="/">
        <xsl:if test="$menu">
            <section id="sitemap">
                <h1>Sitemap</h1>
                <ul>
                    <xsl:apply-templates select="$menu"/>
                </ul>
            </section>
            
        </xsl:if>
    </xsl:template>

    <xsl:template match="menuitem">
        <li>
            <xsl:if test="$stk:device-class = 'desktop'">
                    <xsl:attribute name="style">
                        <xsl:value-of select="concat('width: ', $column-width, 'px;')"/>
                        <xsl:if test="position() mod $number-of-columns != 0">
                            <xsl:value-of select="concat(' margin-right: ', $margin, 'px;')"/>
                        </xsl:if>
                    </xsl:attribute>
                </xsl:if>
            <xsl:choose>
                <xsl:when test="@type = 'label' or @type = 'section'">
                    <div>
                        <xsl:value-of select="stk:menu.menuitem-name(.)"/>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <a href="{portal:createPageUrl(@key, ())}">
                        <xsl:if test="url/@newwindow = 'yes'">
                            <xsl:attribute name="rel">external</xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="stk:menu.menuitem-name(.)"/>
                    </a>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:if test="menuitems/menuitem">
                <ul>
                    <xsl:apply-templates select="menuitems/menuitem"/>
                </ul>
            </xsl:if>
        </li>
    </xsl:template>

</xsl:stylesheet>
