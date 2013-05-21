<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" version="2.0" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"    
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
    <xsl:import href="/modules/library-stk/image.xsl"/>    
    
    <xsl:output method="xhtml"/>
    
    <xsl:variable name="context" select="/result/context" />
    <xsl:variable name="querystring" select="$context/querystring" />
    <xsl:variable name="resource" select="$context/resource" />

    <xsl:template match="/">
        <xsl:choose>
            <!-- Search result -->
            <xsl:when test="$querystring/parameter[@name='locationKey']">
                <xsl:variable name="locationKey" select="$querystring/parameter[@name='locationKey']"/>
                <p> You searched for spots in    
                    <xsl:choose>
                        <xsl:when test="$locationKey and not($resource/path/resource[@key=$locationKey]/display-name='')">
                            <span class="capitalize">
                                <xsl:value-of select="$resource/path/resource[@key=$locationKey]/display-name"/>
                            </span>
                        </xsl:when>
                        <xsl:otherwise>
                            <span class="capitalize"><xsl:value-of select="$resource/display-name"/></span>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:if test="$querystring/parameter[@name='spottags']">
                        <xsl:variable name="spottags" select="$querystring/parameter[@name='spottags']"/>
                        <xsl:text> related to </xsl:text>
                        <xsl:for-each select="/result/tags/contents/content">
                            <xsl:if test="contains($spottags, @key)">
                                <span><xsl:value-of select="display-name"/><xsl:text> </xsl:text></span>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:if>
                </p>
            </xsl:when>
            <!-- At a country or area -->
            <xsl:when test="$resource/@type = 'menuitem'">
                <h1>
                    <xsl:value-of select="$resource/display-name" />
                </h1>
                <p>Showing spots near <xsl:value-of select="$resource/display-name" /></p>
                <ul class="spot nearby list">    
                    <xsl:apply-templates select="/result/spots-nearby/contents/content" mode="spots-nearby"/>
                </ul>
            </xsl:when>
            <!-- At a spot -->
            <xsl:when test="count(/result/spots-nearby/contents/content) gt 1">
                    <h4>Spots nearby</h4>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="content" mode="spots-nearby">
        <xsl:if test="not(current()/@key = /result/context/resource/@key)">
            <li class="spot">
                <xsl:if test="/result/context/resource/@key=current()/@key">
                    <xsl:attribute name="class">spot active</xsl:attribute>
                </xsl:if>

                <xsl:variable name="spottags" select="/result/context/querystring/parameter[@name='spottags']"/>
                <xsl:variable name="locationKey" select="/result/context/querystring/parameter[@name='locationKey']"/>
                <xsl:variable name="spotUrl">
                    <xsl:value-of select="portal:createContentUrl(@key,('locationKey', $locationKey))"/>
                    <xsl:if test="$locationKey and string-length($spottags)>0">
                        <xsl:text>&amp;spottags=</xsl:text>
                        <xsl:value-of select="$spottags"/>
                    </xsl:if>
                </xsl:variable>
                <a href="{$spotUrl}">
                    <xsl:if test="../relatedcontents/content[@key = current()/contentdata/image[1]/image/@key]">
                        <xsl:call-template name="stk:image.create">
                            <xsl:with-param name="image" select="../relatedcontents/content[@key = current()/contentdata/image[1]/image/@key]"/>
                            <xsl:with-param name="scaling" select="if ($stk:device-class = 'mobile') then 'scaleblock(320,120)' else 'scaleblock(155,90)'"/>
                        </xsl:call-template>
                    </xsl:if>
                </a>
                <div class="content">
                    <h3>
                        <a href="{$spotUrl}">
                            <xsl:value-of select="display-name"/>
                        </a>
                    </h3>
                </div>
            </li>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
