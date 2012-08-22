<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
    <xsl:import href="/modules/library-stk/image.xsl"/>  
    <xsl:import href="/modules/library-stk/pagination.xsl"/>
    <xsl:import href="/modules/library-stk/time.xsl"/>  
    <xsl:import href="/modules/library-stk/text.xsl"/>  
    
    <xsl:output method="xhtml"/>
            
    <xsl:template match="/">
        <xsl:choose>
            <xsl:when test="/result/events/contents/content">
                <xsl:call-template name="stk:pagination.create-header">
                    <xsl:with-param name="contents" select="/result/events/contents"/>
                </xsl:call-template>
                <ol id="event-list">                    
                    <xsl:apply-templates select="/result/events/contents/content"/>
                </ol>
                <xsl:call-template name="stk:pagination.create-menu">
                    <xsl:with-param name="contents" select="/result/events/contents"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:value-of select="portal:localize('event.no-events')"/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="content">
        <xsl:variable name="start-date" select="contentdata/start-date"/>
        <xsl:variable name="start-time" select="contentdata/start-time"/>
        <xsl:variable name="end-date" select="contentdata/end-date"/>
        <xsl:variable name="end-time" select="contentdata/end-time"/>
        <li>
            <span class="date">
                <span class="day">
                    <xsl:value-of select="day-from-date(xs:date($start-date))"/>
                </span>
                <span class="month">
                    <xsl:value-of select="format-date(xs:date($start-date), '[MN,*-3]', $stk:language, (), ())"/>
                </span>
            </span>
            <h2>
                <a href="{portal:createContentUrl(@key)}">
                    <xsl:value-of select="contentdata/heading"/>
                </a>
            </h2>
            <div class="time">
                <span>
                    <xsl:value-of select="concat(portal:localize('event.when'), ': ')"/>
                </span>
                <xsl:variable name="date">
                    <xsl:value-of select="$start-date"/>
                    <xsl:if test="normalize-space($start-time)">
                        <xsl:value-of select="concat(' ', $start-time)"/>
                    </xsl:if>
                </xsl:variable>
                
                <xsl:call-template name="stk:time.format-date">
                    <xsl:with-param name="date" select="$date"/>
                    <xsl:with-param name="include-time" select="true()"/>
                </xsl:call-template>
                <xsl:if test="$end-date gt $start-date or $end-time != ''">
                    <xsl:text> -</xsl:text>
                    <xsl:if test="$end-date gt $start-date">                        
                        <xsl:call-template name="stk:time.format-date">
                            <xsl:with-param name="date" select="$end-date"/>
                        </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="$end-time != ''">                        
                        <xsl:call-template name="stk:time.format-time">
                            <xsl:with-param name="time" select="$end-time"/>
                        </xsl:call-template>
                    </xsl:if>
                </xsl:if>                
            </div>
            <xsl:if test="normalize-space(contentdata/location)">
                <div class="location">
                    <span>                        
                        <xsl:value-of select="concat(' ', portal:localize('event.where'), ': ')"/> 
                    </span>                   
                    <xsl:value-of select="contentdata/location"/>
                </div>
            </xsl:if>
        </li>
    </xsl:template>
    
</xsl:stylesheet>
