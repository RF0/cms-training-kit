<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    <xsl:import href="/modules/library-stk/image.xsl"/>
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <h1>Testing images</h1>
        
        <xsl:call-template name="stk:image.create">
            <xsl:with-param name="image" select="/result/contents/content[1]"/>
        </xsl:call-template>
        
        <script>
            $(function() {
                $('img').each(function() {
                    var img = $(this);
                    var srcset = jQuery.parseJSON(img.data('srcset'));
                    var width = this.width;
                    
                    console.log(srcset);
                });
            
            });
            
            
        </script>
        
    </xsl:template>
    
    <!-- Generates image element -->
    <xsl:template name="stk:image.create">
        <xsl:param name="image" as="element()"/><!-- Image content node -->
        <xsl:param name="scaling" as="xs:string?"/>
        <xsl:param name="size" as="xs:string?"/>
        <xsl:param name="background" as="xs:string?"/>
        <xsl:param name="title" as="xs:string?" select="$image/title"/>
        <xsl:param name="alt" as="xs:string?" select="if (normalize-space($image/contentdata/description)) then $image/contentdata/description else $image/title"/>
        <xsl:param name="class" as="xs:string?"/>
        <xsl:param name="style" as="xs:string?"/>
        <xsl:param name="id" as="xs:string?"/>
        <xsl:param name="format" as="xs:string?" select="$stk:default-image-format"/>
        <xsl:param name="quality" as="xs:integer?" select="$stk:default-image-quality"/>
        <xsl:param name="region-width" as="xs:integer" select="$stk:region-width"/>
        <xsl:param name="filter" as="xs:string?" select="$stk:config-filter"/>
        <!-- ensure that we have a trailing semicolon -->
        <xsl:variable name="final-scaling" as="xs:string?" select="if (normalize-space($scaling) and not(ends-with($scaling, ';'))) then concat($scaling, ';') else $scaling"/>
        <xsl:variable name="width" select="stk:image.get-size($region-width, $size, concat($final-scaling, $filter), $image, 'width')"/>
        <xsl:variable name="height" select="stk:image.get-size($region-width, $size, concat($final-scaling, $filter), $image, 'height')"/>
        
        
        <figure>
            
            <noscript>
                <img alt="{$alt}">
                    <xsl:attribute name="src">
                        <xsl:call-template name="stk:image.create-url">
                            <xsl:with-param name="image" select="$image"/>
                            <xsl:with-param name="scaling" select="$final-scaling"/>
                            <xsl:with-param name="size" select="$size"/>
                            <xsl:with-param name="background" select="$background"/>
                            <xsl:with-param name="format" select="$format"/>
                            <xsl:with-param name="quality" select="$quality"/>
                            <xsl:with-param name="region-width" select="300"/>
                            <xsl:with-param name="filter" select="$filter"/>
                        </xsl:call-template>
                    </xsl:attribute>
                </img>
            </noscript>
            
            <xsl:variable name="data-srcset">
                <xsl:for-each select="64, 128, 256, 512, 1024">
                    <xsl:text>{'</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text>':</xsl:text>
                    <xsl:call-template name="stk:image.create-url">
                        <xsl:with-param name="image" select="$image"/>
                        <xsl:with-param name="region-width" select="."/>
                    </xsl:call-template>
                    <xsl:text>}</xsl:text>
                    <xsl:if test="position() != last()">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
            </xsl:variable>
            
            
            <img
                class="js-img" 
                data-srcset="{$data-srcset}"
                src="data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7" width="600" height="300"/>
            
            
            
            <!--data-srcset="[{80:cropid},{160:cropid},..{1200:cropid}]" -->
            
        </figure>
        
        
        
    </xsl:template>
    
</xsl:stylesheet>