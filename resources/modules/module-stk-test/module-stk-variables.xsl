<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/> 
    
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>stk-variables</h1>
        
        <dl>
            <dt>stk:current-resource</dt>
            <dd>
                <xsl:copy-of select="$stk:current-resource"/>                
            </dd>
            
            <dt>stk:site-name</dt>
            <dd>
                <xsl:value-of select="$stk:site-name"/>                
            </dd>
            
            <dt>stk:rendered-page</dt>
            <dd>
                <xsl:copy-of select="$stk:rendered-page"/>                
            </dd>
            
            <dt>stk:path</dt>
            <dd>
                <xsl:value-of select="$stk:path"/>                
            </dd>
            
            <dt>stk:language</dt>
            <dd>
                <xsl:value-of select="$stk:language"/>                
            </dd>
            
            <dt>stk:device-class</dt>
            <dd>
                <xsl:value-of select="$stk:device-class"/>                
            </dd>
            
            <dt>stk:user</dt>
            <dd>
                <xsl:copy-of select="$stk:user"/>                
            </dd>
            
            <dt>stk:public-resources</dt>
            <dd>
                <xsl:value-of select="$stk:public-resources"/>                
            </dd>
            
            <dt>stk:querystring-parameter</dt>
            <dd>
                <xsl:copy-of select="$stk:querystring-parameter"/>                
            </dd>
            
            <dt>stk:region-width</dt>
            <dd>
                <xsl:value-of select="$stk:region-width"/>                
            </dd>
            
            <dt>stk:config</dt>
            <dd>
                <xsl:copy-of select="$stk:config"/>                
            </dd>
            
            <dt>stk:config-parameter</dt>
            <dd>
                <xsl:copy-of select="$stk:config-parameter"/>                
            </dd>
            
            <dt>stk:config-theme</dt>
            <dd>
                <xsl:value-of select="$stk:config-theme"/>                
            </dd>
            
            <dt>stk:theme-location</dt>
            <dd>
                <xsl:value-of select="$stk:theme-location"/>                
            </dd>
            
            <dt>stk:theme-config</dt>
            <dd>
                <xsl:copy-of select="$stk:theme-config"/>                
            </dd>
            
            <dt>stk:theme-region-prefix</dt>
            <dd>
                <xsl:value-of select="$stk:theme-region-prefix"/>                
            </dd>
            
            <dt>stk:theme-all-devices</dt>
            <dd>
                <xsl:copy-of select="$stk:theme-all-devices"/>                
            </dd>
            
            <dt>stk:theme-device-class</dt>
            <dd>
                <xsl:copy-of select="$stk:theme-device-class"/>                
            </dd>
            
            <dt>stk:theme-public</dt>
            <dd>
                <xsl:value-of select="$stk:theme-public"/>                
            </dd>
            
            <dt>stk:front-page</dt>
            <dd>
                <xsl:value-of select="$stk:front-page"/>                
            </dd>
            
            <dt>stk:error-page</dt>
            <dd>
                <xsl:value-of select="$stk:error-page"/>                
            </dd>
            
            <dt>stk:login-page</dt>
            <dd>
                <xsl:value-of select="$stk:login-page"/>                
            </dd>
            
            <dt>stk:config-filter</dt>
            <dd>
                <xsl:value-of select="$stk:config-filter"/>                
            </dd>
            
            <dt>stk:config-imagesize</dt>
            <dd>
                <xsl:copy-of select="$stk:config-imagesize"/>                
            </dd>
            
            <dt>stk:default-image-format</dt>
            <dd>
                <xsl:value-of select="$stk:default-image-format"/>                
            </dd>
            
            <dt>stk:default-image-quality</dt>
            <dd>
                <xsl:value-of select="$stk:default-image-quality"/>                
            </dd>
        </dl>
    
        
    </xsl:template>
    
    
    
    
</xsl:stylesheet>