<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"    
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
    <xsl:import href="/modules/library-stk/head.xsl"/>
    <xsl:import href="/modules/library-stk/accessibility.xsl"/>    
    <xsl:import href="/modules/library-stk/navigation.xsl"/>
    <xsl:import href="/modules/library-stk/analytics.xsl"/>    
    <xsl:import href="/modules/library-stk/system.xsl"/>
    
    
    <xsl:import href="region-responsive.xsl"/>
    
    <!-- HTML 5 doctype -->
    <xsl:output doctype-system="about:legacy-compat" method="xhtml" encoding="utf-8" indent="no" omit-xml-declaration="yes" include-content-type="no"/>
    
    <!-- page type -->
    <!-- For multiple layouts on one site. Various layouts can be configured in theme.xml, each with a different 'name' attribute on the 'layout' element. -->
    <xsl:param name="layout" as="xs:string" select="'default'"/>
    
    <!-- regions -->
    <!--<xsl:param name="r1-c1">
        <type>region</type>
    </xsl:param>
    <xsl:param name="r2-c1">
        <type>region</type>
    </xsl:param>
    <xsl:param name="r2-c2">
        <type>region</type>
    </xsl:param>
    <xsl:param name="r2-c3">
        <type>region</type>
    </xsl:param>-->
    
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
        <html lang="{$stk:language}">
            <head>
                <title>
                    <xsl:value-of select="stk:navigation.get-menuitem-name($stk:current-resource)"/>
                    <xsl:value-of select="concat(' - ', $stk:site-name)"/>
                </title>
                <link rel="shortcut icon" type="image/x-icon" href="{portal:createResourceUrl(concat($stk:theme-public, '/images/all/favicon.ico'))}"/>
                <xsl:call-template name="stk:head.create-metadata"/>
                <xsl:call-template name="stk:head.create-css"/>
                
                <xsl:call-template name="stk:head.create-js"/>
                <!--<xsl:call-template name="stk:region.create-css">
                    <xsl:with-param name="layout" select="$layout"/>
                </xsl:call-template>-->
                
            </head>
            <body>
                <div id="container">
                    <xsl:call-template name="stk:navigation.create-menu">
                        <xsl:with-param name="menuitems" select="/result/menus/menu/menuitems/menuitem"/>
                        <xsl:with-param name="levels" select="5"/>
                        <xsl:with-param name="class" select="'tester'"/>                        
                        <xsl:with-param name="id" select="'idtest'"/>
                    </xsl:call-template>
                    <!-- Create content bypass links if defined in config -->
                    <xsl:call-template name="stk:accessibility.create-bypass-links"/>
                                        
                    <header>
                        <h1>STK test site</h1>
                    </header>
                    
                    <!-- Renders all regions defined in config -->
                    <xsl:call-template name="stk:region.create">
                        <xsl:with-param name="layout" select="$layout" as="xs:string"/>
                    </xsl:call-template>
                    
                    <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'mobile', 'lifetime', 'session'))}" class="change-device-class" rel="nofollow">
                        <xsl:value-of select="portal:localize('theme-basic.change-to-mobile-version')"/>
                    </a>
                    
                </div>
                <xsl:call-template name="stk:analytics.google"/>
            </body>
        </html>
    </xsl:template>
    
    
    <!-- MOBILE template -->
    <xsl:template name="mobile">
        <html lang="{$stk:language}">
            <head>                
                <title>
                    <xsl:value-of select="stk:navigation.get-menuitem-name($stk:current-resource)"/>
                </title>
                <link rel="shortcut icon" type="image/x-icon" href="{portal:createResourceUrl(concat($stk:theme-public, '/images/all/favicon.ico'))}"/>                
                <xsl:call-template name="stk:head.create-metadata"/>                
                <meta content="minimum-scale=1.0, width=device-width, user-scalable=yes" name="viewport" />
                <meta name="apple-mobile-web-app-capable" content="yes" />
                
                <xsl:call-template name="stk:head.create-js"/>
                <xsl:call-template name="stk:head.create-css"/>
                
                <xsl:call-template name="stk:region.create-css">
                    <xsl:with-param name="layout" select="$layout"/>
                </xsl:call-template>
            </head>
            <body>
                <div id="container">
                    <!-- Create content bypass links if defined in config -->
                    <xsl:call-template name="stk:accessibility.create-bypass-links"/>
                    
                    <!--<xsl:call-template name="stk:menu.render">
                        <xsl:with-param name="menuitems" select="/result/menus/menu/menuitems"/>
                        <xsl:with-param name="levels" select="3"/>
                        <xsl:with-param name="list-id" select="'main-menu'"/>
                    </xsl:call-template>
                    
                    <script type="text/javascript">
                        $(function() {
                            $('#main-menu').enonicTree();
                        });
                    </script>-->
                                        
                    <span class="current-device-class">Mobile version</span>
                    <h1>My first headline</h1>
                    
                    <!-- Renders all regions defined in config -->
                    <xsl:call-template name="stk:region.create">
                        <xsl:with-param name="layout" select="$layout" as="xs:string"/>
                    </xsl:call-template>
                    
                    <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'desktop', 'lifetime', 'session'))}" class="change-device-class" rel="nofollow">
                        <xsl:value-of select="portal:localize('theme-basic.change-to-desktop-version')"/>
                    </a>
                    
                </div>
                <xsl:call-template name="stk:analytics.google"/>
            </body>
        </html>
    </xsl:template>
    
</xsl:stylesheet>
