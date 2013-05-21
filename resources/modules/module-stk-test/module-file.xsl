<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    
    <xsl:import href="/modules/library-stk/file.xsl"/> 
    
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>File</h1>
        
        <xsl:call-template name="file.format-bytes"/>
        <xsl:call-template name="file.create-icon-image"/>        
        <xsl:call-template name="file.get-type"/>      
        <xsl:call-template name="file.get-extension"/>
        <xsl:call-template name="file.create-resource-url"/>
    
    
        
    </xsl:template>
    
    <xsl:template name="file.format-bytes">
        <h2>stk:file.format-bytes</h2>
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.format-bytes(1023)"/>
            <xsl:with-param name="result" select="'1023 B'"/>
        </xsl:call-template>
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.format-bytes(1024)"/>
            <xsl:with-param name="result" select="'1 KB'"/>
        </xsl:call-template>
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.format-bytes(1048575)"/>
            <xsl:with-param name="result" select="'1024 KB'"/>
        </xsl:call-template>
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.format-bytes(1048576)"/>
            <xsl:with-param name="result" select="'1 MB'"/>
        </xsl:call-template>
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.format-bytes(1073741823)"/>
            <xsl:with-param name="result" select="'1024 MB'"/>
        </xsl:call-template>
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.format-bytes(1073741824)"/>
            <xsl:with-param name="result" select="'1 GB'"/>
        </xsl:call-template>
        
        
    </xsl:template>
    
    <xsl:template name="file.create-icon-image">
        <h2>stk:file.create-icon-image</h2>
        
        <xsl:call-template name="stk:file.create-icon-image">
            <xsl:with-param name="file-name" select="'test.jpeg'"/>
        </xsl:call-template>
    </xsl:template>
    
    <xsl:template name="file.get-type">
        <h2>stk:file.get-type</h2>
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.get-type('test.jpeg')"/>
            <xsl:with-param name="result" select="portal:localize('stk.file.image')"/>
        </xsl:call-template>
        
        <p>
            <xsl:text>Should return stk.file.image: </xsl:text> 
            <xsl:value-of select="stk:file.get-type('test.jpeg')"/>
        </p>
    </xsl:template>
    
    <xsl:template name="file.get-extension">
        <h2>stk:file.get-extension</h2>
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.get-extension('test.jpeg')"/>
            <xsl:with-param name="result" select="'jpeg'"/>
        </xsl:call-template>        
         
    </xsl:template>
    
    <xsl:template name="file.create-resource-url">
        <h2>stk:file.create-resource-url</h2>
    <!--    
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.create-resource-url('test.jpeg')"/>
            <xsl:with-param name="result" select="'image'"/>
        </xsl:call-template>
        -->
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.create-resource-url('test.jpg')"/>
            <xsl:with-param name="result" select="portal:createResourceUrl(concat($stk:theme-public, 'img/test.jpg'))"/>
        </xsl:call-template>
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.create-resource-url('test.css')"/>
            <xsl:with-param name="result" select="portal:createResourceUrl(concat($stk:theme-public, 'css/test.css'))"/>
        </xsl:call-template>
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.create-resource-url('test.js')"/>
            <xsl:with-param name="result" select="portal:createResourceUrl(concat($stk:theme-public, 'js/test.js'))"/>
        </xsl:call-template><!--
        
        <xsl:call-template name="stk:test.function">
            <xsl:with-param name="input" select="stk:file.create-resource-url('test.js')"/>
            <xsl:with-param name="result" select="'js'"/>
        </xsl:call-template>-->
        
        <p>
            <xsl:text>Should return image: </xsl:text> 
            <xsl:value-of select="stk:file.create-resource-url('test.jpeg')"/>
        </p>
        <p>
            <xsl:text>Should return css: </xsl:text> 
            <xsl:value-of select="stk:file.create-resource-url('test.css')"/>
        </p>
        <p>
            <xsl:text>Should return js: </xsl:text> 
            <xsl:value-of select="stk:file.create-resource-url('test.js')"/>
        </p>
    </xsl:template>
    
    <xsl:template name="stk:test.function">
        <xsl:param name="input"/>        
        <xsl:param name="result"/>
        <div class="{if (compare($input, $result) = 0) then 'success' else 'fail'}">
            <span class="input">                
                <xsl:value-of select="$input"/>
            </span>     <br/>       
            <span class="result">                
                <xsl:value-of select="$result"/>
            </span>
        </div>
    </xsl:template>
    
    
</xsl:stylesheet>