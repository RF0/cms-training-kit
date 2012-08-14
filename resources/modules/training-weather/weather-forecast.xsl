<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>    
    <xsl:import href="/modules/library-stk/time.xsl"/>
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <xsl:if test="/result/yr-data/weatherdata">
            <xsl:apply-templates select="/result/yr-data/weatherdata"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="weatherdata">
        <div id="weather-forecast">
            <h2>
                <xsl:value-of select="concat('Weather forecast for ', location/name)"/>
            </h2>
            
            <ol>            
                <xsl:apply-templates select="forecast/tabular/time[position() le 6]"/>
            </ol>
            
            <div class="disclaimer">
                Weather forecast from yr.no, delivered by the Norwegian Meteorological Institute and the NRK
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="time">
        <li>
            <div class="time-from">                
                <xsl:call-template name="stk:time.format-date">
                    <xsl:with-param name="date" select="@from"/>
                    <xsl:with-param name="include-time" select="true()"/>
                </xsl:call-template>
            </div>
            <xsl:variable name="symbol-img">
                <xsl:value-of select="format-number(symbol/@number, '00')"/>
                <xsl:value-of select="if (@period = '0') then 'n' else 'd'"/>
                <xsl:text>.png</xsl:text>
            </xsl:variable>
            <img src="{portal:createResourceUrl(concat($stk:theme-public, 'images/all/yr-symbols/', $symbol-img))}" alt="{symbol/@name}"/>
            <div class="temperature">
                <xsl:value-of select="concat(temperature/@value, ' &#176;')"/>
            </div>
        </li>
        
    </xsl:template>
    
    
    <!-- Formats date (and time) -->
    <!-- Valid input formats: ISO 8601 -->
    <xsl:template name="stk:time.format-date">
        <xsl:param name="date"/>
        <xsl:param name="language" as="xs:string?" select="$stk:language"/>
        <xsl:param name="picture" as="xs:string?"/>
        <xsl:param name="include-time" as="xs:boolean?" select="false()"/>
        <xsl:choose>
            <xsl:when test="not($date castable as xs:string)">                
                <xsl:text>Erroneous date format</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="date-parts" select="tokenize(xs:string($date), ' |T')"/>
                <xsl:choose>
                    <xsl:when test="not($date-parts[1] castable as xs:date)">                        
                        <xsl:text>Erroneous date format</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="final-picture">
                            <xsl:choose>
                                <xsl:when test="empty($picture)">
                                    <xsl:choose>
                                        <xsl:when test="$language = 'no'">
                                            <xsl:text>[D01].[M01].[Y0001]</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>[D01]/[M01]/[Y0001]</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose> 
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="$picture"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <span class="date">                            
                            <xsl:value-of select="format-date(xs:date($date-parts[1]), $final-picture)"/>
                        </span>
                        <xsl:if test="$include-time and normalize-space($date-parts[2])">
                            <xsl:call-template name="stk:time.format-time">
                                <xsl:with-param name="time" select="$date-parts[2]"/>
                            </xsl:call-template>
                        </xsl:if>
                    </xsl:otherwise>
                </xsl:choose>                
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- Formats time -->
    <!-- Valid input formats: ISO 8601 and hh:mm -->
    <xsl:template name="stk:time.format-time">
        <xsl:param name="time"/>
        <xsl:param name="language" as="xs:string?" select="$stk:language"/>
        <xsl:param name="picture" as="xs:string?"/>
        
        <xsl:variable name="final-time">
            <xsl:value-of select="$time"/>
            <xsl:if test="count(tokenize(xs:string($time), ':')) lt 3">:00</xsl:if>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="not($final-time castable as xs:time)">
                <xsl:text>Erroneous time format</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="final-picture">
                    <xsl:choose>
                        <xsl:when test="empty($picture)">
                            <xsl:choose>
                                <xsl:when test="$language = 'no'">
                                    <xsl:text>[H01].[m01]</xsl:text>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:text>[H01]:[m01]</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose> 
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$picture"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>
                <span class="time">                    
                    <xsl:value-of select="format-time($final-time, $final-picture)"/>
                </span>
            </xsl:otherwise>
        </xsl:choose>           
    </xsl:template>
    
    
    
    
    
</xsl:stylesheet>
