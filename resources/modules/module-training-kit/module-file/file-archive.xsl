<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
    <xsl:import href="/modules/library-stk/file.xsl"/>
    <xsl:import href="/modules/library-stk/time.xsl"/>
    
    <xsl:output method="xhtml"/>
    
    <xsl:template match="/">
        <div id="file-archive">
            <div class="column heading name">
                <span>
                    <xsl:value-of select="portal:localize('file.name')"/>
                </span>
            </div>
            <div class="column heading date-modified">
                <span>
                    <xsl:value-of select="portal:localize('file.date-modified')"/>
                </span>
            </div>
            <div class="column heading size">
                <span>
                    <xsl:value-of select="portal:localize('file.size')"/>
                </span>
            </div>
            <div class="column heading kind">
                <span>
                    <xsl:value-of select="portal:localize('file.kind')"/>
                </span>
            </div>
           <xsl:if test="/result/file-categories/categories/category/categories/category or /result/files/contents/content[category/@key = /result/file-categories/categories/category/@key]">
               <ul>
                   <xsl:apply-templates select="/result/file-categories/categories/category/categories/category[(@key = /result/files/contents/content/category/@key) or (categories/category)]">
                       <xsl:sort select="@name" order="ascending"/>
                   </xsl:apply-templates>
                   <xsl:apply-templates select="/result/files/contents/content[category/@key = /result/file-categories/categories/category/@key]">
                       <xsl:sort select="title" order="ascending"/>
                   </xsl:apply-templates>
               </ul>
           </xsl:if>
            
            <xsl:call-template name="javascript"/>
        </div>
    </xsl:template>
    
    <xsl:template match="category">
        <li class="folder">
            <div class="column name tooltip" title="{if (description != '') then description else @name}">
                <span>
                    <img class="icon text" alt="{concat(portal:localize('file.folder'), ' ', portal:localize('file.icon'))}" src="{stk:file.create-resource-url('all/icon-folder.png')}"/>
                    <xsl:value-of select="@name"/>
                </span>
            </div>
            <div class="column date-modified">
                <span>
                    <xsl:call-template name="stk:time.format-date">
                        <xsl:with-param name="date" select="@timestamp"/>
                    </xsl:call-template>
                </span>
            </div>
            <div class="column size">
                <span>--</span>
            </div>
            <div class="column kind">
                <span>
                    <xsl:value-of select="portal:localize('file.folder')"/>
                </span>
            </div>
            <xsl:if test="categories/category or /result/files/contents/content[category/@key = current()/@key]">
                <ul>
                    <xsl:apply-templates select="categories/category"/>
                    <xsl:apply-templates select="/result/files/contents/content[category/@key = current()/@key]"/>
                </ul>
            </xsl:if>
        </li>
    </xsl:template>
    
    <xsl:template match="content">
        <li class="file">
                    <div class="column name tooltip" title="{if (contentdata/description != '') then contentdata/description else title}">
                        <span>
                            <xsl:call-template name="stk:file.create-icon-image">
                                <xsl:with-param name="file-name" select="title"/>
                                <xsl:with-param name="icon-folder-path" select="'all'"/>
                            </xsl:call-template>
                            <a href="{portal:createAttachmentUrl(@key, ('download', 'true'))}">
                                <xsl:value-of select="title"/>
                            </a>
                        </span>
                    </div>
                    <div class="column date-modified">
                        <span>
                            <xsl:call-template name="stk:time.format-date">
                                <xsl:with-param name="date" select="@timestamp"/>
                            </xsl:call-template>
                        </span>
                    </div>
                    <div class="column size">
                        <span>
                            <xsl:value-of select="stk:file.format-bytes(binaries/binary[1]/@filesize)"/>
                        </span>
                    </div>
                    <div class="column kind">
                        <span>
                            <xsl:value-of select="stk:file.get-type(title)"/>
                        </span>
                    </div>
        </li>
    </xsl:template>
    
    <xsl:template name="javascript">
        <script type="text/javascript">
            $(function() {
                $('#file-archive .folder span').on('click', function() {
                    $(this).closest('.folder').children('ul').slideToggle();
                });
            });
        </script>
    </xsl:template>
</xsl:stylesheet>