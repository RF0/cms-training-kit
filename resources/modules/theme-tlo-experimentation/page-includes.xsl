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
    
    <xsl:import href="/modules/library-stk/file.xsl"/>
    
    <xsl:import href="region-responsive.xsl"/>
    
    <!-- HTML 5 doctype -->
    <xsl:output doctype-system="about:legacy-compat" method="xhtml" encoding="utf-8" indent="no" omit-xml-declaration="yes" include-content-type="no"/>
        
    
    <!-- Select template based on current device -->
    <xsl:template match="/">
        <!-- Run config check to make sure everything is OK -->
        <xsl:variable name="config-status" select="stk:system.check-config()"/>
        <xsl:choose>
            <xsl:when test="$config-status/node()">
                <xsl:copy-of select="$config-status"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="page"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Desktop template -->
    <xsl:template name="page">
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
                
                <meta content="initial-scale=1, width=device-width, user-scalable=yes" name="viewport" />
                <meta name="apple-mobile-web-app-capable" content="yes" />
                
                <noscript>
                    <style>
                        .js-img {display:none;}
                    </style>
                </noscript>
            </head>
            <body>
                <div id="container">
                    
                    <!-- Create content bypass links if defined in config -->
                    <xsl:call-template name="stk:accessibility.create-bypass-links"/>
                                        
                    <header>
                        <a href="{portal:createPageUrl($stk:front-page, ())}" class="logo">                            
                            <img src="{stk:file.create-resource-url('all/header-logo.png')}" alt="Tine logo"/>
                        </a>
                        <button class="menu-trigger"/>
                        <xsl:call-template name="stk:navigation.create-menu">
                            <xsl:with-param name="menuitems" select="/result/menus/menu/menuitems/menuitem"/>
                            <xsl:with-param name="levels" select="5"/>
                            <xsl:with-param name="class" select="'tester'"/>                        
                            <xsl:with-param name="id" select="'idtest'"/>
                        </xsl:call-template>
                        <form method="post" action="#">
                            <input name="query" type="text"/>
                        </form>
                    </header>
                    
                    <!-- Renders all regions defined in config -->
                    <xsl:call-template name="stk:region.create">
                        <xsl:with-param name="layout" select="$layout" as="xs:string"/>
                    </xsl:call-template>
                    
                </div>
                <xsl:call-template name="stk:analytics.google"/>
            </body>
        </html>
    </xsl:template>   
    
    
</xsl:stylesheet>
