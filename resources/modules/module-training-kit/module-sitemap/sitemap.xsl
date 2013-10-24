<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
    <xsl:import href="/modules/library-stk/navigation.xsl"/>
    
    <xsl:output method="xhtml"/>    

    <xsl:variable name="menu" as="element()*" select="/result/menus/menu/menuitems/menuitem"/>

    <xsl:template match="/">
        <xsl:if test="$menu">
            <section class="sitemap">
                <h1>Sitemap</h1>
                <ul>
                    <xsl:apply-templates select="$menu"/>
                </ul>
            </section>
            
        </xsl:if>
    </xsl:template>

    <xsl:template match="menuitem">
        <li>
            <xsl:choose>
                <xsl:when test="@type = 'label' or @type = 'section'">
                    <div>
                        <xsl:value-of select="stk:navigation.get-menuitem-name(.)"/>
                    </div>
                </xsl:when>
                <xsl:otherwise>
                    <a href="{portal:createPageUrl(@key, ())}">
                        <xsl:if test="url/@newwindow = 'yes'">
                            <xsl:attribute name="rel">external</xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="stk:navigation.get-menuitem-name(.)"/>
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
