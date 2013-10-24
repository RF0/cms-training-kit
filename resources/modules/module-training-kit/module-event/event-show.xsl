<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
    <xsl:import href="/modules/library-stk/file.xsl"/>  
    <xsl:import href="/modules/library-stk/html.xsl"/>  
    <xsl:import href="/modules/library-stk/image.xsl"/>  
    <xsl:import href="/modules/library-stk/time.xsl"/>  
    <xsl:import href="/modules/library-stk/text.xsl"/>  
    
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="/result/event/contents/content">
                <article class="event-show">
                    <xsl:apply-templates select="/result/event/contents/content"/>
                </article>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:value-of select="portal:localize('event.no-event')"/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="content">
        <xsl:variable name="start-date" select="contentdata/start-date"/>
        <xsl:variable name="start-time" select="contentdata/start-time"/>
        <xsl:variable name="end-date" select="contentdata/end-date"/>
        <xsl:variable name="end-time" select="contentdata/end-time"/>
        <h1>
            <xsl:value-of select="title"/>
        </h1>
        <div class="preface" id="time-location">
            <strong>
                <xsl:value-of select="concat(portal:localize('event.when'), ': ')"/>
            </strong>
            <xsl:variable name="date">
                <xsl:value-of select="$start-date"/>
                <xsl:if test="$start-time != ''">
                    <xsl:value-of select="concat(' ', $start-time)"/>
                </xsl:if>
            </xsl:variable>
            <xsl:call-template name="stk:time.format-date">
                <xsl:with-param name="date" select="$date"/>
                <xsl:with-param name="include-time" select="true()"/>
            </xsl:call-template>
            <xsl:if test="$end-date &gt; $start-date or $end-time != ''">
                <xsl:text> -</xsl:text>
                <xsl:if test="$end-date &gt; $start-date">
                    <xsl:text> </xsl:text>
                    <xsl:call-template name="stk:time.format-date">
                        <xsl:with-param name="date" select="$end-date"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="$end-time != ''">
                    <xsl:text> </xsl:text>
                    <xsl:call-template name="stk:time.format-time">
                        <xsl:with-param name="time" select="$end-time"/>
                    </xsl:call-template>
                </xsl:if>
            </xsl:if>
            <xsl:if test="normalize-space(contentdata/location)">
                <br/>
                <strong>
                    <xsl:value-of select="concat(' ', portal:localize('event.where'), ': ')"/>
                </strong>
                <xsl:value-of select="contentdata/location"/>
            </xsl:if>
        </div>        
        
        <xsl:if test="/result/event/contents/relatedcontents/content[@key = current()/contentdata/image/image/@key]">
            <xsl:call-template name="stk:image.create">
                <xsl:with-param name="image" select="/result/event/contents/relatedcontents/content[@key = current()/contentdata/image[1]/image/@key]"/>
                <xsl:with-param name="filter" select="if ($stk:device-class = 'mobile') then 'scalewidth(300)' else 'scalewidth(500)'"/>
            </xsl:call-template>
        </xsl:if>           
        
        <xsl:if test="normalize-space(contentdata/preface)">
            <div class="preface">
                <xsl:call-template name="stk:text.process">
                    <xsl:with-param name="text" select="contentdata/preface"/>
                </xsl:call-template>
            </div>
        </xsl:if>
        <xsl:call-template name="stk:html.process">
            <xsl:with-param name="document" select="contentdata/text"/>
        </xsl:call-template>
    </xsl:template>
        
</xsl:stylesheet>
