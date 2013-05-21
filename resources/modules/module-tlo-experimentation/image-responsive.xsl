<?xml version="1.0" encoding="UTF-8"?>

<!--
    **************************************************
    
    image.xsl
    version: ###VERSION-NUMBER-IS-INSERTED-HERE###
    
    **************************************************
-->

<xsl:stylesheet exclude-result-prefixes="#all"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:portal="http://www.enonic.com/cms/xslt/portal"
    xmlns:stk="http://www.enonic.com/cms/xslt/stk">
    
    <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
    
    <!-- Generates image element -->
    <xsl:template name="stk:image.create">
        <xsl:param name="image" as="element()"/><!-- Image content node -->
        <xsl:param name="scaling" as="xs:string?"/>
        <xsl:param name="size" as="xs:string?"/>
        <xsl:param name="filter" as="xs:string?" select="$stk:config-filter"/>                
        <xsl:param name="format" as="xs:string?" select="$stk:default-image-format"/>
        <xsl:param name="quality" as="xs:integer?" select="$stk:default-image-quality"/>        
        <xsl:param name="background" as="xs:string?"/>
        <xsl:param name="title" as="xs:string?" select="$image/title"/>
        <xsl:param name="alt" as="xs:string?" select="if (normalize-space($image/contentdata/description)) then $image/contentdata/description else $image/title"/>
        <xsl:param name="class" as="xs:string?"/>
        <xsl:param name="style" as="xs:string?"/>
        <xsl:param name="id" as="xs:string?"/>
        
        <figure>   
            <noscript>
                <img alt="{$alt}">
                    <xsl:attribute name="src">
                        <xsl:call-template name="stk:image.create-url">
                            <xsl:with-param name="image" select="$image"/>
                            <xsl:with-param name="scaling" select="$scaling"/>
                            <xsl:with-param name="size" select="$size"/>                            
                            <xsl:with-param name="filter" select="$filter"/>
                            <xsl:with-param name="format" select="$format"/>
                            <xsl:with-param name="quality" select="$quality"/>
                            <xsl:with-param name="scale-width" select="300"/>                            
                            <xsl:with-param name="background" select="$background"/>
                        </xsl:call-template>
                    </xsl:attribute>
                </img>
            </noscript>
                        
            <xsl:variable name="data-srcset">
                <xsl:text>{</xsl:text>
                <xsl:for-each select="64, 128, 256, 512, 1024, 2048">
                    <xsl:variable name="src-width" select="."/>
                    <xsl:text>"</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text>":"</xsl:text>
                    <xsl:call-template name="stk:image.create-url">
                        <xsl:with-param name="image" select="$image"/>
                        <xsl:with-param name="scaling" select="$scaling"/>
                        <xsl:with-param name="size" select="$size"/>                        
                        <xsl:with-param name="filter" select="$filter"/>
                        <xsl:with-param name="format" select="$format"/>
                        <xsl:with-param name="quality" select="$quality"/>
                        <xsl:with-param name="scale-width" select="$src-width"/>
                        <xsl:with-param name="background" select="$background"/>
                    </xsl:call-template>
                    <xsl:text>"</xsl:text>
                    <xsl:if test="position() != last()">
                        <xsl:text>,</xsl:text>
                    </xsl:if>                    
                </xsl:for-each>
                <xsl:text>}</xsl:text>
            </xsl:variable>
            <img>
                <xsl:attribute name="alt" select="$alt"/>
                <xsl:attribute name="data-srcset" select="$data-srcset"/>
                <xsl:attribute name="class">
                    <xsl:text>js-img </xsl:text>
                    <xsl:value-of select="$size"/>
                    <xsl:if test="normalize-space($scaling)">
                        <xsl:text> scaled</xsl:text>
                    </xsl:if>
                </xsl:attribute>
                <xsl:attribute name="src" select="'data:image/gif;base64,R0lGODlh3AVFA4AAAP///wAAACH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IChNYWNpbnRvc2gpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjJCNzdERkRGQTk5QjExRTI4RDlFOUNCREU2MkMxQTY4IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjJCNzdERkUwQTk5QjExRTI4RDlFOUNCREU2MkMxQTY4Ij4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MkI3N0RGRERBOTlCMTFFMjhEOUU5Q0JERTYyQzFBNjgiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MkI3N0RGREVBOTlCMTFFMjhEOUU5Q0JERTYyQzFBNjgiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4B//79/Pv6+fj39vX08/Lx8O/u7ezr6uno5+bl5OPi4eDf3t3c29rZ2NfW1dTT0tHQz87NzMvKycjHxsXEw8LBwL++vby7urm4t7a1tLOysbCvrq2sq6qpqKempaSjoqGgn56dnJuamZiXlpWUk5KRkI+OjYyLiomIh4aFhIOCgYB/fn18e3p5eHd2dXRzcnFwb25tbGtqaWhnZmVkY2JhYF9eXVxbWllYV1ZVVFNSUVBPTk1MS0pJSEdGRURDQkFAPz49PDs6OTg3NjU0MzIxMC8uLSwrKikoJyYlJCMiISAfHh0cGxoZGBcWFRQTEhEQDw4NDAsKCQgHBgUEAwIBAAAh+QQBAAAAACwAAAAA3AVFAwAC/4SPqcvtD6OctNqLs968+w+G4kiW5omm6sq27gvH8kzX9o3n+s73/g8MCofEovGITCqXzKbzCY1Kp9Sq9YrNarfcrvcLDovH5LL5jE6r1+y2+w2Py+f0uv2Oz+v3/L7/DxgoOEhYaHiImKi4yNjo+AgZKTlJWWl5iZmpucnZ6fkJGio6SlpqeoqaqrrK2ur6ChsrO0tba3uLm6u7y9vr+wscLDxMXGx8jJysvMzc7PwMHS09TV1tfY2drb3N3e39DR4uPk5ebn6Onq6+zt7u/g4fLz9PX29/j5+vv8/f7/8PMKDAgQQLGjyIMKHChQwbOnwIMaLEiRQrWryIMaPGjf8cO3r8CDKkyJEkS5o8iTKlypUsW7p8CTOmzJk0a9q8iTOnzp08e/r8CTSo0KFEixo9ijSp0qVMmzp9CjWq1KlUq1q9ijWr1q1cu3r9Cjas2LFky5o9izat2rVs27p9Czeu3Ll069q9izev3r18+/r9Cziw4MGECxs+jDix4sWMGzt+DDmy5MmUK1u+jDmz5s2cO3v+DDq06NGkS5s+jTq16tWsW7t+DTu27Nm0a9u+jTu37t28e/v+DTy48OHEixs/jjy58uXMmzt/Dj269OnUq1u/jj279u3cu3v/Dj68+PHky5s/jz69+vXs27t/Dz++/Pn069u/jz+//v38+/v//w9ggAIOSGCBBh6IYIIKLshggw4+CGGEEk5IYYUWXohhhhpuyGGHHn4IYogijkhiiSaeiGKKKq7IYosuvghjjDLOSGONNt6IY4467shjjz7+CGSQQg5JZJFGHolkkkouyWSTTj4JZZRSTklllVZeiWWWWm7JZZdefglmmGKOSWaZZp6JZppqrslmm26+CWeccs5JZ5123olnnnruyWeffv4JaKCCDkpooYYeimiiii7KaKOOPgpppJJOSmmlll6Kaaaabsppp55+Cmqooo5Kaqmmnopqqqquymqrrr4Ka6yyzkprrbbeimuuuu7Ka6++/gpssMIOS2yxxh6LbLLK/y7LbLPOPgtttNJOS2211l6Lbbbabsttt95+C2644o5Lbrnmnotuuuquy2677r4Lb7zyzktvvfbei2+++u7Lb7/+/gtwwAIPTHDBBh+McMIKL8xwww4/DHHEEk9MccUWX4xxxhpvzHHHHn8Mcsgij0xyySafjHLKKq/McssuvwxzzDLPTHPNNt+Mc84678xzzz7/DHTQQg9NdNFGH4100kovzXTTTj8NddRST0111VZfjXXWWm/Ndddefw122GKPTXbZZp+Ndtpqr812226/DXfccs9Nd91234133nrvzXfffv8NeOCCD0544YYfjnjiii/OeOOOPw555JJPTnnllv9fjnnmmm/Oeeeefw566KKPTnrppp+Oeuqqr856666/Dnvsss9Oe+2234577rrvznvvvv8OfPDCD0988cYfj3zyyi/PfPPOPw999NJPT3311l+Pffbab899995/D3744o9Pfvnmn49++uqvz3777r8Pf/zyz09//fbfj3/++u/Pf//+/w/AAApwgAQsoAEPiMAEKnCBDGygAx8IwQhKcIIUrKAFL4jBDGpwgxzsoAc/CMIQinCEJCyhCU+IwhSqcIUsbKELXwjDGMpwhjSsoQ1viMMc6nCHPOyhD38IxCAKcYhELKIRj4jEJCpxiUxsohOfCMUoSnGKVKyiFa+IxSz/anGLXOyiF78IxjCKcYxkLKMZz4jGNKpxjWxsoxvfCMc4ynGOdKyjHe+IxzzqcY987KMf/wjIQApykIQspCEPichEKnKRjGykIx8JyUhKcpKUrKQlL4nJTGpyk5zspCc/CcpQinKUpCylKU+JylSqcpWsbKUrXwnLWMpylrSspS1victc6nKXvOylL38JzGAKc5jELKYxj4nMZCpzmcxspjOfCc1oSnOa1KymNa+JzWxqc5vc7KY3vwnOcIpznOQspznPic50qnOd7GynO98Jz3jKc570rKc974nPfOpzn/zspz//CdCACnSgBC2oQQ+K0IQqdKEMbahDHwrRiEp0/6IUrahFL4rRjGp0oxztqEc/CtKQinSkJC2pSU+K0pSqdKUsbalLXwrTmMp0pjStqU1vitOc6nSnPO2pT38K1KAKdahELapRj4rUpCp1qUxtqlOfCtWoSnWqVK2qVa+K1axqdatc7apXvwrWsIp1rGQtq1nPita0qnWtbG2rW98K17jKda50ratd74rXvOp1r3ztq1//CtjACnawhC2sYQ+L2MQqdrGMbaxjHwvZyEp2spStrGUvi9nManaznO2sZz8L2tCKdrSkLa1pT4va1Kp2taxtrWtfC9vYyna2tK2tbW+L29zqdre87a1vfwvc4Ap3uMQtrnGPi9zkKne5zJNtrnOfC93oSne61K2uda+L3exqd7vc7a53vwve8Ip3vOQtr3nPi970qne97G2ve98L3/jKd770ra9974vf/Op3v/ztr3//C+AAC3jABC6wgQ+M4AQreMEMbrCDHwzhCEt4whSusIUvjOEMa3jDHO6whz8M4hCLeMQkLrGJT4ziFKt4xSxusYtfDOMYy3jGNMZFAQAAOw=='"/>
            </img>            
        </figure>
    </xsl:template>
    
    <!-- Generates image url -->
    <xsl:template name="stk:image.create-url">
        <xsl:param name="image" as="element()"/><!-- Image content node -->
        <xsl:param name="scaling" as="xs:string?"/>
        <xsl:param name="size" as="xs:string?"/>        
        <xsl:param name="filter" as="xs:string?" select="$stk:config-filter"/><!-- Custom image filters -->
        <xsl:param name="format" as="xs:string?" select="$stk:default-image-format"/>
        <xsl:param name="quality" as="xs:integer?" select="$stk:default-image-quality"/>
        <xsl:param name="scale-width" as="xs:integer" select="$stk:img-max-width"/>        
        <xsl:param name="background" as="xs:string?"/>
        <!-- ensure that we have a trailing semicolon -->
        <xsl:variable name="final-scaling" as="xs:string?" select="if (normalize-space($scaling) and not(ends-with($scaling, ';'))) then concat($scaling, ';') else $scaling"/>
        <xsl:value-of select="portal:createImageUrl(
            stk:image.get-attachment-key($image, $scale-width), 
            stk:image.create-filter($scaling, $scale-width, $size, concat($final-scaling, $filter), $image), 
            $background,
            $format,
            $quality
            )"/>
    </xsl:template>

    <!-- Returns final image filter as xs:string? -->
    <xsl:function name="stk:image.create-filter" as="xs:string?">        
        <xsl:param name="scaling" as="xs:string?"/>
        <xsl:param name="scale-width" as="xs:integer"/>
        <xsl:param name="size" as="xs:string?"/>
        <xsl:param name="filter" as="xs:string?"/>
        <xsl:param name="image" as="element()"/>
        <xsl:variable name="selected-imagesize" select="$stk:config-imagesize[@name = $size]"/>
        <xsl:variable name="source-image-size" as="xs:integer*" select="$image/contentdata/sourceimage/@width, $image/contentdata/sourceimage/@height"/>
        
        <xsl:variable name="size-scaled" as="xs:string?">
            <xsl:choose>
                <!-- If custom image size definitions exists -->
                <xsl:when test="$selected-imagesize">
                    <!-- Supports all scale filters -->
                    <xsl:variable name="first-filter-parameter">
                        <xsl:choose>
                            <xsl:when test="$selected-imagesize/filter = 'scalemax' or $selected-imagesize/filter = 'scalesquare'">
                                <xsl:value-of select="$selected-imagesize/size"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="$selected-imagesize/width"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:variable>
                    
                    
                    
                    <xsl:value-of select="concat($selected-imagesize/filter, '(', floor($scale-width))"/>
                    <xsl:if test="$selected-imagesize/filter = 'scalewide' and $selected-imagesize/height != ''">
                        <xsl:value-of select="concat(',', floor($scale-width * $selected-imagesize/height))"/>
                        <xsl:if test="$selected-imagesize/offset != ''">
                            <xsl:value-of select="concat(',', $selected-imagesize/offset)"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:text>);</xsl:text>
                </xsl:when>
                <!-- If no custom image size definitions exists default sizes are used -->
                <xsl:when test="$size = 'full' or $size = 'regular' or $size = 'list'">
                    <xsl:value-of select="concat('scalewidth(', $scale-width, ');')"/>
                </xsl:when>
                <xsl:when test="$size = 'wide'">
                    <xsl:value-of select="concat('scalewide(', $scale-width, ',', $scale-width * 0.4, ');')"/>
                </xsl:when>
                <xsl:when test="$size = 'square' or $size = 'thumbnail'">
                    <xsl:value-of select="concat('scalesquare(', $scale-width, ');')"/>
                </xsl:when>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="custom-scaled" as="xs:string?">
            <xsl:variable name="last-scale-filter" select="tokenize($filter, ';')[starts-with(., 'scale')][position() = last()]"/>            
            <xsl:choose>
                <xsl:when test="$last-scale-filter">
                    <xsl:variable name="scale-type" select="tokenize($last-scale-filter, '\(')[1]"/>
                    <xsl:variable name="scale-params" as="xs:double*">
                        <xsl:for-each select="tokenize(tokenize($last-scale-filter, '\(|\)')[2], ',')">
                            <xsl:sequence select="number(.)"/>
                        </xsl:for-each>
                    </xsl:variable>
                    <xsl:value-of select="concat($scale-type, '(')"/>
                    <xsl:if test="$scale-type = 'scalewide' or $scale-type = 'scalewidth' or $scale-type = 'scalemax' or $scale-type = 'scalesquare' or $scale-type = 'scaleblock'">
                        <xsl:value-of select="if ($scale-params[1] gt $scale-width) then $scale-width else $scale-params[1]"/>
                    </xsl:if>
                    <xsl:if test="$scale-type = 'scaleheight'">
                        <xsl:value-of select="if (stk:image.calculate-size($source-image-size, (), $scale-params[1]) gt $scale-width) then stk:image.calculate-size($source-image-size, $scale-width, ()) else $scale-params[1]"/>    
                    </xsl:if>
                    <xsl:if test="$scale-type = 'scalewide' or $scale-type = 'scaleblock'">
                        <xsl:text>,</xsl:text>
                        <xsl:value-of select="if ($scale-params[1] gt $scale-width) then $scale-width * ($scale-params[2] div $scale-params[1]) else $scale-params[2]"/>
                        <xsl:if test="$scale-params[3]">
                            <xsl:value-of select="concat(',', $scale-params[3])"/>
                        </xsl:if>
                        <xsl:if test="$scale-params[4]">
                            <xsl:value-of select="concat(',', $scale-params[4])"/>
                        </xsl:if>
                    </xsl:if>
                    <xsl:value-of select="');'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="concat('scalewidth(', $scale-width, ');')"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="final-filter">
                <xsl:choose>
                    <xsl:when test="$size-scaled">
                        <xsl:value-of select="$size-scaled"/>
                    </xsl:when>
                    <xsl:when test="$custom-scaled">
                        <xsl:value-of select="$custom-scaled"/>
                    </xsl:when>
                </xsl:choose>
                                
                <xsl:for-each select="tokenize($filter, ';')[not(starts-with(., 'scale'))][normalize-space(.)]">
                    <xsl:value-of select="concat(., ';')"/>
                </xsl:for-each> 
            
        </xsl:variable>
        <xsl:value-of select="translate($final-filter, ' ', '')"/>
    </xsl:function>
    
    <!-- Returns final image width or height as xs:integer? -->
    <!--<xsl:function name="stk:image.get-size" as="xs:integer?">
        <xsl:param name="region-width" as="xs:integer"/>
        <xsl:param name="size" as="xs:string?"/>
        <xsl:param name="scaling" as="xs:string?"/>
        <xsl:param name="source-image" as="element()?"/>
        <xsl:param name="dimension" as="xs:string?"/>
        <xsl:variable name="selected-imagesize" select="$stk:config-imagesize[@name = $size]"/>
        <xsl:variable name="source-image-size" as="xs:integer*" select="$source-image/contentdata/sourceimage/@width, $source-image/contentdata/sourceimage/@height"/> 
        <xsl:variable name="final-image-size" as="xs:double*">
            <xsl:choose>
                <!-\- If custom scale filter applied. Possible weakness here; only the last scalefilter is taken into consideration -\->
                <xsl:when test="normalize-space($scaling) and count(tokenize($scaling, ';')[starts-with(., 'scale')]) gt 0">
                    <xsl:variable name="last-scale-filter" select="tokenize($scaling, ';')[starts-with(., 'scale')][position() = last()]"/>
                    <xsl:variable name="scale-type" select="tokenize($last-scale-filter, '\(')[1]"/>                    
                    <xsl:variable name="scale-params" as="xs:double*">
                        <xsl:for-each select="tokenize(tokenize($last-scale-filter, '\(|\)')[2], ',')">
                            <xsl:sequence select="number(.)"/>
                        </xsl:for-each>
                    </xsl:variable>
                    
                    <!-\- make sure that the image fits within the current region width -\->
                    <xsl:choose>
                        <xsl:when test="$scale-type = 'scalewidth'">
                            <xsl:value-of select="if ($scale-params[1] gt $region-width) then $region-width else $scale-params[1]"/>                            
                            <xsl:value-of select="stk:image.calculate-size($source-image-size, if ($scale-params[1] gt $region-width) then $region-width else $scale-params[1], ())"/>   
                         </xsl:when>
                         <xsl:when test="$scale-type = 'scaleheight'">
                            <xsl:value-of select="if (stk:image.calculate-size($source-image-size, (), $scale-params[1]) gt $region-width) then $region-width else stk:image.calculate-size($source-image-size, (), $scale-params[1])"/> 
                            <xsl:value-of select="if (stk:image.calculate-size($source-image-size, (), $scale-params[1]) gt $region-width) then stk:image.calculate-size($source-image-size, $region-width, ()) else $scale-params[1]"/>    
                        </xsl:when>                        
                        <xsl:when test="$scale-type = 'scalesquare'">
                            <xsl:value-of select="if ($scale-params[1] gt $region-width) then $region-width else $scale-params[1]"/>
                            <xsl:value-of select="if ($scale-params[1] gt $region-width) then $region-width else $scale-params[1]"/>
                        </xsl:when>
                        <xsl:when test="$scale-type = 'scalemax'">
                            <xsl:choose>
                                <xsl:when test="$source-image-size[1] ge $source-image-size[2]">
                                    <xsl:value-of select="if ($scale-params[1] gt $region-width) then $region-width else $scale-params[1]"/>
                                    <xsl:value-of select="stk:image.calculate-size($source-image-size, if ($scale-params[1] gt $region-width) then $region-width else $scale-params[1], ())"/> 
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="if (stk:image.calculate-size($source-image-size, (), $scale-params[1]) gt $region-width) then $region-width else stk:image.calculate-size($source-image-size, (), $scale-params[1])"/>    
                                    <xsl:value-of select="if (stk:image.calculate-size($source-image-size, (), $scale-params[1]) gt $region-width) then stk:image.calculate-size($source-image-size, $region-width, ()) else $scale-params[1]"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:when test="$scale-type = 'scaleblock'">
                            <xsl:value-of select="if ($scale-params[1] gt $region-width) then $region-width else $scale-params[1]"/>
                            <xsl:value-of select="if ($scale-params[1] gt $region-width) then $region-width * ($scale-params[2] div $scale-params[1]) else $scale-params[2]"/>
                        </xsl:when>
                        <xsl:when test="$scale-type = 'scalewide'">
                            <xsl:value-of select="if ($scale-params[1] gt $region-width) then $region-width else $scale-params[1]"/>
                            <xsl:value-of select="min((stk:image.calculate-size($source-image-size, if ($scale-params[1] gt $region-width) then $region-width else $scale-params[1], ()), if ($scale-params[1] gt $region-width) then $scale-params[2] * ($region-width div $scale-params[1]) else $scale-params[2]))"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
                <!-\- If custom image size definitions exists -\->
                <xsl:when test="$selected-imagesize">
                    <!-\- Supports all scale filters -\->
                    <xsl:choose>
                        <!-\- Scaleheight -\->
                        <xsl:when test="$selected-imagesize/filter = 'scaleheight'">
                            <xsl:sequence select="stk:image.calculate-size($source-image-size, (), floor($region-width * $selected-imagesize/height)), floor($region-width * $selected-imagesize/height)"/>
                        </xsl:when>
                        <!-\- Scalemax -\->
                        <xsl:when test="$selected-imagesize/filter = 'scalemax'">
                            <xsl:choose>
                                <xsl:when test="$source-image-size[1] ge $source-image-size[2]">
                                    <xsl:sequence select="floor($region-width * $selected-imagesize/size), stk:image.calculate-size($source-image-size, floor($region-width * $selected-imagesize/size), ())"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:sequence select="stk:image.calculate-size($source-image-size, (), floor($region-width * $selected-imagesize/size)), floor($region-width * $selected-imagesize/size)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <!-\- Scalesquare -\->
                        <xsl:when test="$selected-imagesize/filter = 'scalesquare'">
                            <xsl:sequence select="floor($region-width * $selected-imagesize/size), floor($region-width * $selected-imagesize/size)"/>
                        </xsl:when>
                        <!-\- Scalewide -\->
                        <xsl:when test="$selected-imagesize/filter = 'scalewide'">
                            <xsl:sequence select="floor($region-width * $selected-imagesize/width)"/>
                            <xsl:choose>
                                <xsl:when test="stk:image.calculate-size($source-image-size, floor($region-width * $selected-imagesize/width), ()) le floor($region-width * $selected-imagesize/height)">
                                    <xsl:sequence select="stk:image.calculate-size($source-image-size, floor($region-width * $selected-imagesize/width), ())"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:sequence select="floor($region-width * $selected-imagesize/height)"/>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <!-\- Scaleblock -\->
                        <xsl:when test="$selected-imagesize/filter = 'scaleblock'">
                            <xsl:sequence select="floor($region-width * $selected-imagesize/width), floor($region-width * $selected-imagesize/height)"/>
                        </xsl:when>
                        <!-\- Scalewidth -\->
                        <xsl:when test="$selected-imagesize/filter = 'scalewidth'">
                            <xsl:sequence select="floor($region-width * $selected-imagesize/width), stk:image.calculate-size($source-image-size, floor($region-width * $selected-imagesize/width), ())"/>
                        </xsl:when>
                    </xsl:choose>
                </xsl:when>
                <!-\- If no custom image size definitions exists default sizes are used -\->
                <xsl:when test="$size = 'full' or $size = 'regular' or $size = 'list'">
                    <xsl:sequence select="stk:image.calculate-size-by-default-ratio($region-width, $size), stk:image.calculate-size($source-image-size, stk:image.calculate-size-by-default-ratio($region-width, $size), ())"/>
                </xsl:when>
                <xsl:when test="$size = 'wide'">
                    <xsl:sequence select="stk:image.calculate-size-by-default-ratio($region-width, 'wide-width')"/>
                    <xsl:choose>
                        <xsl:when test="stk:image.calculate-size($source-image-size, stk:image.calculate-size-by-default-ratio($region-width, 'wide-width'), ()) le stk:image.calculate-size-by-default-ratio($region-width, 'wide-height')">
                            <xsl:sequence select="stk:image.calculate-size($source-image-size, stk:image.calculate-size-by-default-ratio($region-width, 'wide-width'), ())"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:sequence select="stk:image.calculate-size-by-default-ratio($region-width, 'wide-height')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="$size = 'square' or $size = 'thumbnail'">
                    <xsl:sequence select="stk:image.calculate-size-by-default-ratio($region-width, $size), stk:image.calculate-size-by-default-ratio($region-width, $size)"/>
                </xsl:when>
                <!-\- Original image size -\->
                <!-\-<xsl:otherwise>
                    <xsl:sequence select="$source-image-size[1], $source-image-size[2]"/>
                </xsl:otherwise>-\->
                <xsl:otherwise>
                    <xsl:value-of select="$region-width"/>
                    <xsl:value-of select="stk:image.calculate-size($source-image-size, $region-width, ())"/>  
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>        
        <xsl:choose>
            <xsl:when test="$dimension = 'height' and $final-image-size[2]">
                <xsl:value-of select="$final-image-size[2]"/>
            </xsl:when>
            <xsl:when test="$final-image-size[1]">
                <xsl:value-of select="$final-image-size[1]"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>-->
    
    <!-- Returns final image attachment key as xs:string -->
    <xsl:function name="stk:image.get-attachment-key" as="xs:string">
        <xsl:param name="source-image" as="element()"/>
        <xsl:param name="scale-width" as="xs:integer"/><!--
        <xsl:param name="size" as="xs:string?"/>--><!--
        <xsl:param name="scaling" as="xs:string?"/>--><!--
        <xsl:variable name="image-width" select="stk:image.get-size($region-width, $size, $scaling, $source-image, 'width')"/>-->
        <xsl:variable name="attachment-key">
            <xsl:value-of select="$source-image/@key"/>
            <xsl:choose>
                <xsl:when test="$scale-width le 256 and $source-image/binaries/binary/@label = 'small'">/label/small</xsl:when>
                <xsl:when test="$scale-width le 512 and $source-image/binaries/binary/@label = 'medium'">/label/medium</xsl:when>
                <xsl:when test="$scale-width le 1024 and $source-image/binaries/binary/@label = 'large'">/label/large</xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$attachment-key"/>
    </xsl:function>
    
    <!-- Returns size based on default ratio as xs:integer -->
    <xsl:function name="stk:image.calculate-size-by-default-ratio" as="xs:integer">
        <xsl:param name="region-width" as="xs:integer"/>
        <xsl:param name="size" as="xs:string"/>
        <xsl:variable name="ratio">
            <xsl:choose>
                <xsl:when test="$size = 'full'">1</xsl:when>
                <xsl:when test="$size = 'wide-width'">1</xsl:when>
                <xsl:when test="$size = 'wide-height'">0.4</xsl:when>
                <xsl:when test="$size = 'regular'">0.4</xsl:when>
                <xsl:when test="$size = 'list'">0.3</xsl:when>
                <xsl:when test="$size = 'square'">0.4</xsl:when>
                <xsl:when test="$size = 'thumbnail'">0.1</xsl:when>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="floor($region-width * $ratio)"/>
    </xsl:function>
    
    <!-- Returns width calculated from new-height, old-width and old-height, or height calculated from new-width, old-width and old-height as xs:double? -->
    <xsl:function name="stk:image.calculate-size" as="xs:double?">
        <xsl:param name="source-image-size" as="xs:integer*"/>
        <xsl:param name="new-width" as="xs:double?"/>
        <xsl:param name="new-height" as="xs:double?"/>
        <!-- $source-image-size[1] is old width -->
        <!-- $source-image-size[2] is old height -->
        <xsl:if test="$source-image-size[1] and $source-image-size[2]">
            <xsl:choose>
                <xsl:when test="$new-width">
                    <xsl:value-of select="floor($new-width div ($source-image-size[1] div $source-image-size[2]))"/>
                </xsl:when>
                <xsl:when test="$new-height">
                    <xsl:value-of select="floor($new-height * ($source-image-size[1] div $source-image-size[2]))"/>
                </xsl:when>
            </xsl:choose>
        </xsl:if>
    </xsl:function>
    
    
    


</xsl:stylesheet>
