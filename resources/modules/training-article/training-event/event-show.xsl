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
                <article id="event">
                    <xsl:apply-templates select="/result/event/contents/content"/>
                </article>
            </xsl:when>
            <xsl:otherwise>
                <p>
                    <xsl:value-of select="portal:localize('No-event')"/>
                </p>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="content">
        <xsl:variable name="start-date" select="contentdata/start-date"/>
        <xsl:variable name="start-time" select="contentdata/start-time"/>
        <xsl:variable name="end-date" select="contentdata/end-date"/>
        <xsl:variable name="end-time" select="contentdata/end-time"/>
        <div class="date">
            <span class="day">
                <xsl:value-of select="day-from-date(xs:date($start-date))"/>
            </span>
            <span class="month">
                <xsl:value-of select="format-date(xs:date($start-date), '[MN,*-3]', $stk:language, (), ())"/>
            </span>
        </div>
        <h1>
            <xsl:value-of select="title"/>
        </h1>
        <p class="preface" id="time-location">
            <strong>
                <xsl:value-of select="concat(portal:localize('When'), ': ')"/>
            </strong>
            <xsl:variable name="date">
                <xsl:value-of select="$start-date"/>
                <xsl:if test="$start-time != ''">
                    <xsl:value-of select="concat(' ', $start-time)"/>
                </xsl:if>
            </xsl:variable>
            <xsl:value-of select="stk:time.format-date($date, $stk:language, (), true())"/>
            <xsl:if test="$end-date &gt; $start-date or $end-time != ''">
                <xsl:text> -</xsl:text>
                <xsl:if test="$end-date &gt; $start-date">
                    <xsl:value-of select="concat(' ', stk:time.format-date($end-date, $stk:language, (), ()))"/>
                </xsl:if>
                <xsl:if test="$end-time != ''">
                    <xsl:value-of select="concat(' ', stk:time.format-time($end-time, $stk:language))"/>
                </xsl:if>
            </xsl:if>
            <xsl:if test="contentdata/location != ''">
                <br/>
                <strong>
                    <xsl:value-of select="concat(' ', portal:localize('Where'), ': ')"/>
                </strong>
                <xsl:value-of select="contentdata/location"/>
            </xsl:if>
        </p>
        <xsl:choose>
            <xsl:when test="$stk:device-class = 'mobile'">
                <xsl:if test="/result/event/contents/relatedcontents/content[@key = current()/contentdata/image[1]/image/@key]">
                    <div class="related">
                        <div class="image">
                            <xsl:call-template name="stk:image.create">
                                <xsl:with-param name="image" select="/result/event/contents/relatedcontents/content[@key = current()/contentdata/image[1]/image/@key]"/>
                                <xsl:with-param name="size" select="'full'"/>
                            </xsl:call-template>
                            <xsl:value-of select="contentdata/image[position() = 1 and image/@key = /result/event/contents/relatedcontents/content/@key]/image_text"/>
                        </div>
                    </div>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="related-content">
                    <xsl:with-param name="size" select="'regular'"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="contentdata/preface">
            <p class="preface">
                <xsl:value-of disable-output-escaping="yes" select="replace(contentdata/preface, '\n', '&lt;br /&gt;')"/>
            </p>
        </xsl:if>
        <xsl:call-template name="stk:html.process">
            <xsl:with-param name="document" select="contentdata/text"/>
        </xsl:call-template>
        <xsl:if test="$stk:device-class = 'mobile'">
            <xsl:call-template name="related-content">
                <xsl:with-param name="size" select="'full'"/>
                <xsl:with-param name="start" select="2"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
    
    <xsl:template name="related-content">
        <xsl:param name="size"/>
        <xsl:param name="start" select="1"/>
        <xsl:if test="/result/event/contents/relatedcontents/content[@key = current()/contentdata/image[position() &gt;= $start]/image/@key] or contentdata/link/url != '' or /result/event/contents/relatedcontents/content[@key = current()/contentdata/articles/content/@key] or /result/event/contents/relatedcontents/content[@key = current()/contentdata/file/file/file/@key] or /result/event/contents/relatedcontents/content[@key = current()/contentdata/events/content/@key]">
            <div class="related">
                <xsl:if test="not($stk:device-class = 'mobile')">
                    <xsl:attribute name="style">
                        <xsl:value-of select="concat('width: ', floor($stk:region-width * $stk:config-imagesize[@name = $size]/width), 'px;')"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="/result/event/contents/relatedcontents/content[@key = current()/contentdata/image[position() &gt;= $start]/image/@key]">
                    <xsl:for-each select="contentdata/image[position() &gt;= $start and image/@key = /result/event/contents/relatedcontents/content/@key]">
                        <div class="image">
                            <xsl:call-template name="stk:image.create">
                                <xsl:with-param name="image" select="/result/event/contents/relatedcontents/content[@key = current()/image/@key]"/>
                                <xsl:with-param name="size" select="$size"/>
                            </xsl:call-template>
                            <xsl:value-of select="image_text"/>
                        </div>
                    </xsl:for-each>
                </xsl:if>
                <xsl:if test="contentdata/link/url != ''">
                    <h4>
                        <xsl:value-of select="portal:localize('Related-links')"/>
                    </h4>
                    <ul>
                        <xsl:for-each select="contentdata/link[url != '']">
                            <li>
                                <a href="{url}">
                                    <xsl:if test="target = 'new'">
                                        <xsl:attribute name="rel">external</xsl:attribute>
                                    </xsl:if>
                                    <xsl:value-of select="if (description != '') then description else url"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="/result/event/contents/relatedcontents/content[@key = current()/contentdata/articles/content/@key]">
                    <h4>
                        <xsl:value-of select="portal:localize('Related-articles')"/>
                    </h4>
                    <ul>
                        <xsl:for-each select="contentdata/articles/content[@key = /result/event/contents/relatedcontents/content/@key]">
                            <xsl:variable name="current-article" select="/result/event/contents/relatedcontents/content[@key = current()/@key]"/>
                            <li>
                                <a href="{portal:createContentUrl($current-article/@key, ())}">
                                    <xsl:value-of select="$current-article/title"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="/result/event/contents/relatedcontents/content[@key = current()/contentdata/file/file/file/@key]">
                    <h4>
                        <xsl:value-of select="portal:localize('Related-files')"/>
                    </h4>
                    <ul>
                        <xsl:for-each select="contentdata/file/file/file[@key = /result/event/contents/relatedcontents/content/@key]">
                            <xsl:variable name="current-file" select="/result/event/contents/relatedcontents/content[@key = current()/@key]"/>
                            <li>
                                <a href="{portal:createBinaryUrl($current-file/contentdata/binarydata/@key, ('download', 'true'))}">
                                    <xsl:call-template name="stk:file.create-icon-image">
                                        <xsl:with-param name="file-name" select="$current-file/title"/>
                                        <xsl:with-param name="icon-folder-path" select="concat($stk:theme-public, '/images')"/>
                                    </xsl:call-template>
                                    <xsl:value-of select="$current-file/title"/>
                                </a>
                                <xsl:value-of select="concat(' (', stk:file.format-bytes($current-file/binaries/binary/@filesize), ')')"/>
                                <xsl:if test="$current-file/contentdata/description != ''">
                                    <br/>
                                    <xsl:value-of select="stk:text.crop($current-file/contentdata/description, 200)"/>
                                </xsl:if>
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="/result/event/contents/relatedcontents/content[@key = current()/contentdata/events/content/@key]">
                    <h4>
                        <xsl:value-of select="portal:localize('Related-events')"/>
                    </h4>
                    <ul>
                        <xsl:for-each select="contentdata/events/content[@key = /result/event/contents/relatedcontents/content/@key]">
                            <xsl:variable name="current-event" select="/result/event/contents/relatedcontents/content[@key = current()/@key]"/>
                            <li>
                                <a href="{portal:createContentUrl($current-event/@key, ())}">
                                    <xsl:value-of select="$current-event/title"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
            </div>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>
