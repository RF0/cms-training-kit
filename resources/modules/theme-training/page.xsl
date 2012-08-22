<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"    
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
    <xsl:import href="/modules/library-stk/region.xsl"/>
    <xsl:import href="/modules/library-stk/head.xsl"/>
    <xsl:import href="/modules/library-stk/accessibility.xsl"/>    
    <xsl:import href="/modules/library-stk/menu.xsl"/>
    <xsl:import href="/modules/library-stk/google.xsl"/>    
    <xsl:import href="/modules/library-stk/system.xsl"/>
    <xsl:import href="/modules/library-stk/menu.xsl"/>
    
    <!-- HTML 5 doctype -->
    <xsl:output doctype-system="about:legacy-compat" method="xhtml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" include-content-type="no"/>
    
    <!-- page type -->
    <!-- For multiple layouts on one site. Various layouts can be configured in theme.xml, each with a different 'name' attribute on the 'layout' element. -->
    <xsl:param name="layout" as="xs:string" select="'default'"/>
    
    <!-- regions -->
    <xsl:param name="north">
        <type>region</type>
    </xsl:param>
    <xsl:param name="west">
        <type>region</type>
    </xsl:param>
    <xsl:param name="center">
        <type>region</type>
    </xsl:param>
    <xsl:param name="east">
        <type>region</type>
    </xsl:param>
    <xsl:param name="south">
        <type>region</type>
    </xsl:param>
    
    <!-- Select template based on current device -->
    <xsl:template match="/">
        <!-- Run config check to make sure everything is OK -->
        <xsl:variable name="config-status" select="stk:system.check-config()"/>
        <xsl:choose>
            <xsl:when test="$config-status/node()">
                <xsl:copy-of select="$config-status"/>
            </xsl:when>
            <xsl:when test="$stk:device-class = 'mobile'">
                <xsl:call-template name="mobile"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="desktop"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Desktop template -->
    <xsl:template name="desktop">
        <html>
            <head>
                <title>
                    <xsl:value-of select="stk:menu.menuitem-name($stk:current-resource)"/>
                    <xsl:value-of select="concat(' - ', $stk:site-name)"/>
                </title>
                <xsl:call-template name="stk:head.create-metadata"/>
                <xsl:call-template name="stk:head.create-javascript"/>
                <xsl:call-template name="stk:head.create-css"/>
                
                <xsl:call-template name="stk:region.create-css">
                    <xsl:with-param name="layout" select="$layout"/>
                </xsl:call-template>
            </head>
            <body>
                <div id="container">
                    <header>
                        <div id="enonic-header">
                            <img src="{portal:createResourceUrl(concat($stk:theme-public, 'images/all/enonic-training-kit-logo-small.png'))}" alt="Enonic Logo"/>
                        </div>
                        
                        <xsl:call-template name="stk:menu.render">
                            <xsl:with-param name="menuitems" select="/result/menus/menu/menuitems"/>
                            <xsl:with-param name="levels" select="1"/>
                            <xsl:with-param name="list-id" select="'main-menu'"/>
                        </xsl:call-template>
                        
                        <!-- Create content bypass links if defined in config -->
                        <xsl:call-template name="stk:accessibility.create-bypass-links"/>
                    </header>
                    
                    <div id="main-content">
                        <!-- Renders all regions defined in config -->
                        <xsl:call-template name="stk:region.render">
                            <xsl:with-param name="layout" select="$layout" as="xs:string"/>
                        </xsl:call-template>
                        
                        <!-- Print standard message if page does not contain any portlets -->
                        <xsl:if test="not(/result/context/page/regions/region/windows/node())">
                            <div class="welcome-to-the-training-kit">                                
                                <h1>Welcome to the Enonic Training kit. </h1>
                                <p>This message will disappear when you add a portlet to this page.</p>
                            </div>
                        </xsl:if>
                    </div>
                    
                    <footer>
                        <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'mobile', 'lifetime', 'session'))}" class="change-device-class" rel="nofollow">
                            <xsl:value-of select="portal:localize('theme-training.change-to-mobile-version')"/>
                        </a>
                    </footer>
                    
                </div>
                <xsl:call-template name="stk:google.analytics"/>
            </body>
        </html>
    </xsl:template>
    
    
    <!-- MOBILE template -->
    <xsl:template name="mobile">
        <html>
            <head>                
                <title>
                    <xsl:value-of select="stk:menu.menuitem-name($stk:current-resource)"/>
                </title>
                <xsl:call-template name="stk:head.create-metadata"/>                
                <meta content="minimum-scale=1.0, width=device-width, user-scalable=yes" name="viewport" />
                <meta name="apple-mobile-web-app-capable" content="yes" />
                
                <xsl:call-template name="stk:head.create-javascript"/>
                <xsl:call-template name="stk:head.create-css"/>
                
                <xsl:call-template name="stk:region.create-css">
                    <xsl:with-param name="layout" select="$layout"/>
                </xsl:call-template>
            </head>
            <body>
                <div id="container">
                    <header>
                        <a href="#" id="toggle-main-menu">
                            <xsl:value-of select="portal:localize('menu.toggle-menu')"/>
                        </a>
                        <xsl:call-template name="stk:menu.render">
                            <xsl:with-param name="menuitems" select="/result/menus/menu/menuitems"/>
                            <xsl:with-param name="levels" select="1"/>
                            <xsl:with-param name="list-id" select="'main-menu'"/>
                        </xsl:call-template>
                    </header>
                    
                    <div id="main-content">
                        <!-- Renders all regions defined in config -->
                        <xsl:call-template name="stk:region.render">
                            <xsl:with-param name="layout" select="$layout" as="xs:string"/>
                        </xsl:call-template>
                        
                        <!-- Print standard message if page does not contain any portlets -->
                        <xsl:if test="not(/result/context/page/regions/region/windows/node())">
                            <div class="welcome-to-the-training-kit">                                
                                <h1>Welcome to the Enonic Training kit. </h1>
                                <p>This message will disappear when you add a portlet to this page.</p>
                            </div>
                        </xsl:if>
                    </div>
                    
                    <footer>
                        <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'desktop', 'lifetime', 'session'))}" class="change-device-class" rel="nofollow">
                            <xsl:value-of select="portal:localize('theme-training.change-to-desktop-version')"/>
                        </a>
                    </footer>
                    
                </div>
                <xsl:call-template name="stk:google.analytics"/>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
