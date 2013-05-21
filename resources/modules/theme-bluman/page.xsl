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
    <xsl:import href="/modules/library-stk/google.xsl"/>    
    <xsl:import href="/modules/library-stk/system.xsl"/>
    
    <xsl:import href="/modules/library-stk/navigation.xsl"/>
    
    <xsl:import href="/modules/library-stk/image.xsl"/>
    
    <xsl:import href="/modules/library-stk/file.xsl"/>

    <xsl:import href="widgets/spot-slideshow.xsl"/>
    
    <!-- HTML 5 doctype -->
    <xsl:output doctype-system="about:legacy-compat" method="xhtml" encoding="utf-8" indent="no" omit-xml-declaration="yes" include-content-type="no"/>
    

    <!-- page type -->
    <!-- For multiple layouts on one site. Various layouts can be configured in theme.xml, each with a different 'name' attribute on the 'layout' element. -->
    <xsl:param name="layout" select="'default'" as="xs:string"/>
    <xsl:param name="body-class" select="''" as="xs:string"/>

    <!-- regions -->
    <xsl:param name="north"><type>region</type></xsl:param>
    <xsl:param name="west"><type>region</type></xsl:param>
    <xsl:param name="center"><type>region</type></xsl:param>
    <xsl:param name="south"><type>region</type></xsl:param>
    <xsl:param name="east"><type>region</type></xsl:param>
    <xsl:param name="background"><type>region</type></xsl:param>

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

    <xsl:template name="desktop">
        <!--[if lt IE 7]> <html class="no-js ie6 oldie" dir="ltr" lang="{$language}" xml:lang="{$language}" > <![endif]-->
        <!--[if IE 7]>    <html class="no-js ie7 oldie" dir="ltr" lang="{$language}" xml:lang="{$language}" > <![endif]-->
        <!--[if IE 8]>    <html class="no-js ie8 oldie" dir="ltr" lang="{$language}" xml:lang="{$language}" > <![endif]-->
        <!--[if gt IE 8]><!--> <html class="no-js" dir="ltr" lang="{$stk:language}" xml:lang="{$stk:language}" > <!--<![endif]-->
        <head>
            <title>
                <xsl:value-of select="stk:navigation.get-menuitem-name($stk:current-resource)"/>
                <xsl:value-of select="concat(' - ', $stk:site-name)"/>
            </title>
            <link rel="shortcut icon" type="image/x-icon" href="{stk:file.create-resource-url('all/favicon.ico')}"/>
            <xsl:call-template name="stk:head.create-metadata"/>
            <xsl:call-template name="stk:head.create-css"/>
            
            <xsl:call-template name="stk:region.create-css">
                <xsl:with-param name="layout" select="$layout"/>
            </xsl:call-template>
            <xsl:call-template name="stk:head.create-javascript"/>
        </head>

        <body>
            <xsl:if test="normalize-space($body-class)">
                <xsl:attribute name="class" select="$body-class"/>
            </xsl:if>
            
            <xsl:call-template name="desktop.body" />
            <xsl:call-template name="background-images" />
        </body>
    </html>
    </xsl:template>
        
        <xsl:template name="background-images">
            <script type="text/javascript">
                $(function() {                    
                    $('.slideshow img').each(function() {
                   	    $(this).fullBg();
                   	});
                   	
                    $('.slideshow').cycle({
                        fx: 'fade',
                        speed: 500,
                   		pager: '.slideshow-pager',
                   		timeout: 8000,
                   		pagerAnchorBuilder: function(idx, slide) {  
                            return '.slideshow-pager li:eq(' + idx + ') a'; 
                        },
                        after: function(curr, next, opt) {
                            showDescription(next.getAttribute('data-imagekey'));
                        }
                        
                   	});
                   	
                   	function showDescription(imgKey) {
                   	    $('.slideshow-description li').hide();
                        $('.slideshow-description li[data-imagekey='+imgKey+']').show();
                   	}
                   	
                });
            </script>
            <div class="slideshow">
                <xsl:for-each select="/result/slideshow-images/contents/relatedcontents/content[@key = /result/slideshow-images/contents/content/contentdata/image/image/@key]">
                    <xsl:call-template name="stk:image.create">
                        <xsl:with-param name="image" select="current()"/>
                        <xsl:with-param name="scaling" select="'scalewidth(1000)'"/>
                        <xsl:with-param name="region-width" select="1000"/>
                    </xsl:call-template>
                    <!--<img src="{portal:createImageUrl(@key, (''), '' , 'jpg' , 40 )}" data-imagekey="{@key}" width="{$image-data/width}" height="{$image-data/height}" alt=""/>
               --> </xsl:for-each>
                <!--<xsl:for-each select="/result/slideshow-images/contents/content/contentdata/image/image">
                    <xsl:variable name="image-data" select="/result/slideshow-images/contents/relatedcontents/content[current()/@key = @key]/contentdata/images/image" />
                    <img src="{portal:createImageUrl(@key, (''), '' , 'jpg' , 40 )}" data-imagekey="{@key}" width="{$image-data/width}" height="{$image-data/height}" alt=""/>
                </xsl:for-each>-->
            </div>
            <ul class="slideshow-pager">
                <xsl:for-each select="/result/slideshow-images/contents/relatedcontents/content[@key = /result/slideshow-images/contents/content/contentdata/image/image/@key]">
                    <li>
                        
                        <a href="#">
                            <xsl:call-template name="stk:image.create">
                                <xsl:with-param name="image" select="current()"/>
                                <xsl:with-param name="scaling" select="'scaleblock(45,45)'"/>
                                <xsl:with-param name="region-width" select="1000"/>
                            </xsl:call-template>
                            <!--<img height="45" width="45" style="display:block;" alt="">
                                <xsl:attribute name="src">
                                    <xsl:call-template name="stk:image.create-url">
                                        <xsl:with-param name="image" select="."/>
                                        <xsl:with-param name="region-width" select="45"/>
                                    </xsl:call-template>
                                </xsl:attribute>
                                <!-\-src="{portal:createImageUrl(@key, ('scaleblock(45, 45)'))}"-\->
                            </img>-->
                        </a>
                    </li>
                </xsl:for-each>
            </ul>
            <div class="slideshow-description">
                <img src="{stk:file.create-resource-url('all/arrow-right-icon-blue.png')}" class="collapse-ss-description" alt=""/>
                <ul>
                    <xsl:for-each select="/result/slideshow-images/contents/content">

                            <xsl:for-each select="contentdata/image">
                                <li data-imagekey="{image/@key}">
                                    <xsl:if test="position() != 1">
                                        <xsl:attribute name="style">
                                            display:none;
                                        </xsl:attribute>    
                                    </xsl:if>
                                    
                                    "<xsl:value-of select="image_text" />",
                                    <xsl:text> </xsl:text>
                                    <a href="{portal:createContentUrl(../../@key)}"><xsl:value-of select="../../display-name" /></a> 
                                </li>                                    
                            </xsl:for-each>
                        
                    </xsl:for-each>
                </ul>
            </div>
        </xsl:template>

    <xsl:template name="mobile">
        <html lang="{$stk:language}" xml:lang="{$stk:language}">
            <head>
                <title>
                    <xsl:value-of select="stk:navigation.get-menuitem-name($stk:current-resource)"/>
                </title>
                <link rel="apple-touch-icon" href="{stk:file.create-resource-url('mobile/apple-touch-icon.png')}"/>
                <xsl:call-template name="stk:head.create-css"/>

            </head>
            <body>
                <xsl:if test="normalize-space($body-class)">
                    <xsl:attribute name="class" select="$body-class"/>
                </xsl:if>
                <xsl:call-template name="mobile.body" />
            </body>
        </html>
    </xsl:template>

        <xsl:template name="mobile.body">
            <div id="outer-container">
                <!-- Header with logo and search box -->
                <xsl:call-template name="mobile.header" />
                
                
                <nav class="mobile-navigation">
                    <xsl:call-template name="stk:navigation.create-menu">
                        <xsl:with-param name="menuitems" select="/result/menu/menus/menu/menuitems"/>
                        <xsl:with-param name="levels" select="3"/>
                        <xsl:with-param name="class" select="'mobile-menu'"/>
                    </xsl:call-template>
                </nav>
                    <xsl:call-template name="stk:region.create">
                        <xsl:with-param name="region-name" select="'west'" />
                    </xsl:call-template>
                
                <div id="container">
                    <!--<xsl:if test="portal:isWindowEmpty( /result/context/page/regions/region[ name = 'center' ]/windows/window/@key, ('_config-region-width', 500) ) = false()">-->

                        <xsl:call-template name="stk:region.create">
                            <xsl:with-param name="region-name" select="'center'" /><!--
                            <xsl:with-param name="parameters" as="xs:anyAtomicType*">
                                <xsl:sequence select="'_config-region-width', xs:integer(500)"/>
                            </xsl:with-param>-->
                        </xsl:call-template>
                    
                    <!--</xsl:if>-->
                   <!-- <xsl:if test="portal:isWindowEmpty( /result/context/page/regions/region[ name = 'east' ]/windows/window/@key, ('_config-region-width', 180) ) = false()">
                        <div id="east">
                            <xsl:call-template name="stk:region.render">
                                <xsl:with-param name="region-name" select="'east'" /><!-\-
                                <xsl:with-param name="parameters" as="xs:anyAtomicType*">
                                    <xsl:sequence select="'_config-region-width', xs:integer(180)"/>
                                </xsl:with-param>-\->
                            </xsl:call-template>
                        </div>
                    </xsl:if>-->
                </div>            
            </div>
            <!-- Footer -->
            <xsl:call-template name="mobile.footer" />
        </xsl:template>
        
        <xsl:template name="mobile.header">
            <header id="header">
                <a href="{portal:createPageUrl($stk:front-page,())}">
                    <img alt="{$stk:site-name}-{portal:localize('theme-bluman.logo')}" id="logo" src="{stk:file.create-resource-url('mobile/logo-small.png')}" title="{$stk:site-name}"/>
                </a>
                <a href="#" class="toggle search">
                    Toggle search
                </a>
                <a href="#" class="toggle menu">
                    Toggle menu
                </a>
            </header>
        </xsl:template>
        
        <xsl:template name="mobile.footer">
            <footer id="footer">
                <p>
                    <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'desktop', 'lifetime', 'session'))}" class="change-device">
                        <img src="{stk:file.create-resource-url('mobile/icon-desktop.png')}" alt="{portal:localize('theme-bluman.change-to-desktop-version')}"/>
                        <xsl:value-of select="portal:localize('theme-bluman.change-to-desktop-version')"/>
                    </a>
                </p>
            </footer>
        </xsl:template>
        
        <xsl:template name="desktop.body">
            <div id="page">
                <xsl:call-template name="stk:accessibility.create-bypass-links"/>
                <noscript><p><xsl:value-of select="portal:localize('theme-bluman.javascript-required')"/></p></noscript>
                <xsl:call-template name="desktop.header" />
                    <xsl:call-template name="stk:region.create">
                        <xsl:with-param name="region-name" select="'west'" />
                    </xsl:call-template>
                
                <div class="center-container">
                        <xsl:call-template name="stk:region.create">
                            <xsl:with-param name="region-name" select="'center'" />
                        </xsl:call-template>
                        <a href="{portal:createServicesUrl('portal','forceDeviceClass', ('deviceclass', 'mobile', 'lifetime', 'session'))}" class="change-device">
                            <img src="{stk:file.create-resource-url('desktop/icon-mobile.png')}" alt="{portal:localize('theme-bluman.change-to-mobile-version')}"/>
                            <xsl:value-of select="portal:localize('theme-bluman.change-to-mobile-version')"/>
                        </a>
                    
                    <!--<xsl:if test="portal:isWindowEmpty( /result/context/page/regions/region[ name = 'east' ]/windows/window/@key, ('_config-region-width', 180) ) = false()">
                        <div id="east">
                            <xsl:call-template name="stk:region.render">
                                <xsl:with-param name="region-name" select="'east'" /><!-\-
                                <xsl:with-param name="parameters" as="xs:anyAtomicType*">
                                    <xsl:sequence select="'_config-region-width', xs:integer(180)"/>
                                </xsl:with-param>-\->
                            </xsl:call-template>
                        </div>
                    </xsl:if>-->
                </div>
            </div>
            
        </xsl:template>
    
        
        
        
    
    
        <!--<xsl:function name="stk:theme.resource">
            <xsl:param name="file-path" as="xs:string"/>
            <xsl:variable name="file-extension" as="xs:string?" select="stk:file.get-extension($file-path)"/>            
            <xsl:if test="normalize-space($file-extension)">
                <xsl:variable name="file-type" as="xs:string?">
                    <xsl:choose>
                        <xsl:when test="matches($file-extension, 'png|jpe?g|gif')">
                            <xsl:text>images</xsl:text>
                        </xsl:when>
                        <xsl:when test="$file-extension = 'css'">
                            <xsl:text>css</xsl:text>
                        </xsl:when>
                        <xsl:when test="$file-extension = 'js'">
                            <xsl:text>js</xsl:text>
                        </xsl:when>
                    </xsl:choose>
                </xsl:variable>
                <xsl:if test="normalize-space($file-type)">                    
                    <xsl:value-of select="portal:createResourceUrl(concat($stk:theme-public, '/', $file-type, '/', $file-path))"/>
                </xsl:if>
            </xsl:if>
        </xsl:function>
    
        <xsl:function name="stk:file.get-extension" as="xs:string?">
            <xsl:param name="file-path" as="xs:string"/>
            <xsl:if test="contains($file-path, '.')">
                <xsl:value-of select="lower-case(tokenize($file-path, '\.')[last()])"/>
            </xsl:if>            
        </xsl:function>
    -->
    
        
        <!-- Header template -->
        <!-- Put your static header XSL/HTML here -->
        <xsl:template name="desktop.header">
            <header id="header" role="banner">
                <a class="logo" href="{portal:createPageUrl($stk:front-page,())}">
                    <img alt="{$stk:site-name}-{portal:localize('theme-bluman.logo')}" src="{stk:file.create-resource-url('desktop/logo-small.png')}" title="{$stk:site-name}"/>
                </a>
                <div id="nav-wrapper" class="transparent">
                    <nav accesskey="m" class="page" role="navigation">
                        <xsl:call-template name="stk:navigation.create-menu">
                            <xsl:with-param name="menuitems" select="/result/menus/menu/menuitems/menuitem"/>
                            <xsl:with-param name="levels" select="3"/>
                            <xsl:with-param name="class" select="'mainmenu'" />
                        </xsl:call-template>
                    </nav>
                    <xsl:if test="$stk:user or $stk:login-page or $stk:user">
                        <nav accesskey="l" class="login" role="navigation">
                            <xsl:call-template name="desktop.userimage" />
                            <xsl:call-template name="desktop.userinfo" />
                        </nav>
                    </xsl:if>
                </div>
                <xsl:call-template name="stk:navigation.create-breadcrumbs"/>
                
            </header>
        </xsl:template>
        
        <xsl:template name="desktop.userinfo">
            <xsl:if test="$stk:user or $stk:login-page">
                <ul>
                    <xsl:choose>
                        <!-- User logged in -->
                        <xsl:when test="$stk:user">
                            <li>
                                <xsl:choose>
                                    <xsl:when test="$stk:login-page">
                                        <a href="{portal:createPageUrl($stk:login-page/@key, ())}">
                                            <xsl:value-of select="$stk:user/display-name"/>
                                        </a>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <div>
                                            <xsl:value-of select="$stk:user/display-name"/>
                                        </div>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </li>
                            <li class="last">
                                <a href="{portal:createServicesUrl('user', 'logout')}" >
                                    <xsl:value-of select="portal:localize('theme-bluman.logout')"/>
                                </a>
                            </li>
                        </xsl:when>
                        <!-- User not logged in -->
                        <xsl:when test="$stk:login-page">
                            <li class="last">
                                <a href="{portal:createPageUrl($stk:login-page/@key, ())}">
                                    <xsl:value-of select="portal:localize('theme-bluman.login')"/>
                                </a>
                            </li>
                        </xsl:when>
                    </xsl:choose>
                    <!--<xsl:if test="$sitemap-page != ''">
                        <li class="last">
                            <a href="{portal:createUrl($sitemap-page)}">
                                <xsl:value-of select="portal:localize('Sitemap')"/>
                            </a>
                        </li>
                    </xsl:if>-->
                </ul>
            </xsl:if>
        </xsl:template>
        
        <xsl:template name="desktop.userimage">
            <img src="{if ($stk:user/photo/@exists = 'true') then portal:createImageUrl(concat('user/', $stk:user/@key), 'scalesquare(24);rounded(2)') else stk:file.create-resource-url('all/dummy-user-smallest.png')}" title="{$stk:user/display-name}" alt="{concat(portal:localize('theme-bluman.image-of'), ' ', $stk:user/display-name)}" class="user-image">
                <xsl:if test="$stk:login-page">
                    <xsl:attribute name="class">user-image clickable</xsl:attribute>
                    <xsl:attribute name="onclick">
                        <xsl:value-of select="concat('location.href = &quot;', portal:createPageUrl($stk:login-page/@key, ()), '&quot;;')"/>
                    </xsl:attribute>
                </xsl:if>
            </img>
        </xsl:template>


</xsl:stylesheet>