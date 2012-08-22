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
            <p class="disclaimer">
                Weather forecast from yr.no, delivered by the Norwegian Meteorological Institute and the NRK
            </p>
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
    
</xsl:stylesheet>
