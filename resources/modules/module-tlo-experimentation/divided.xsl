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
        
        <div class="row">
            <div class="span-6 col">
                <xsl:call-template name="stk:image.create">
                    <xsl:with-param name="image" select="/result/contents/content[1]"/>
                </xsl:call-template>
            </div>
            <div class="span-6 col">
                <xsl:call-template name="stk:image.create">
                    <xsl:with-param name="image" select="/result/contents/content[1]"/>
                </xsl:call-template>
            </div>
        </div>
        
        
        
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
                <xsl:text>{</xsl:text>
                <xsl:for-each select="64, 128, 256, 512, 1024, 1500">
                    <xsl:variable name="src-width" select="."/>
                    <xsl:text>"</xsl:text>
                    <xsl:value-of select="."/>
                    <xsl:text>":"</xsl:text>
                    <xsl:call-template name="stk:image.create-url">
                        <xsl:with-param name="image" select="$image"/>
                        <xsl:with-param name="region-width" select="$src-width"/>
                    </xsl:call-template>
                    <xsl:text>"</xsl:text>
                    <xsl:if test="position() != last()">
                        <xsl:text>,</xsl:text>
                    </xsl:if>
                </xsl:for-each>
                <xsl:text>}</xsl:text>
            </xsl:variable>
            
            
            
            <img
                class="js-img" 
                data-srcset="{$data-srcset}"
                src="data:image/gif;base64,R0lGODlh3AVFA4AAAP///wAAACH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS4zLWMwMTEgNjYuMTQ1NjYxLCAyMDEyLzAyLzA2LTE0OjU2OjI3ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M2IChNYWNpbnRvc2gpIiB4bXBNTTpJbnN0YW5jZUlEPSJ4bXAuaWlkOjJCNzdERkRGQTk5QjExRTI4RDlFOUNCREU2MkMxQTY4IiB4bXBNTTpEb2N1bWVudElEPSJ4bXAuZGlkOjJCNzdERkUwQTk5QjExRTI4RDlFOUNCREU2MkMxQTY4Ij4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MkI3N0RGRERBOTlCMTFFMjhEOUU5Q0JERTYyQzFBNjgiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MkI3N0RGREVBOTlCMTFFMjhEOUU5Q0JERTYyQzFBNjgiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4B//79/Pv6+fj39vX08/Lx8O/u7ezr6uno5+bl5OPi4eDf3t3c29rZ2NfW1dTT0tHQz87NzMvKycjHxsXEw8LBwL++vby7urm4t7a1tLOysbCvrq2sq6qpqKempaSjoqGgn56dnJuamZiXlpWUk5KRkI+OjYyLiomIh4aFhIOCgYB/fn18e3p5eHd2dXRzcnFwb25tbGtqaWhnZmVkY2JhYF9eXVxbWllYV1ZVVFNSUVBPTk1MS0pJSEdGRURDQkFAPz49PDs6OTg3NjU0MzIxMC8uLSwrKikoJyYlJCMiISAfHh0cGxoZGBcWFRQTEhEQDw4NDAsKCQgHBgUEAwIBAAAh+QQBAAAAACwAAAAA3AVFAwAC/4SPqcvtD6OctNqLs968+w+G4kiW5omm6sq27gvH8kzX9o3n+s73/g8MCofEovGITCqXzKbzCY1Kp9Sq9YrNarfcrvcLDovH5LL5jE6r1+y2+w2Py+f0uv2Oz+v3/L7/DxgoOEhYaHiImKi4yNjo+AgZKTlJWWl5iZmpucnZ6fkJGio6SlpqeoqaqrrK2ur6ChsrO0tba3uLm6u7y9vr+wscLDxMXGx8jJysvMzc7PwMHS09TV1tfY2drb3N3e39DR4uPk5ebn6Onq6+zt7u/g4fLz9PX29/j5+vv8/f7/8PMKDAgQQLGjyIMKHChQwbOnwIMaLEiRQrWryIMaPGjf8cO3r8CDKkyJEkS5o8iTKlypUsW7p8CTOmzJk0a9q8iTOnzp08e/r8CTSo0KFEixo9ijSp0qVMmzp9CjWq1KlUq1q9ijWr1q1cu3r9Cjas2LFky5o9izat2rVs27p9Czeu3Ll069q9izev3r18+/r9Cziw4MGECxs+jDix4sWMGzt+DDmy5MmUK1u+jDmz5s2cO3v+DDq06NGkS5s+jTq16tWsW7t+DTu27Nm0a9u+jTu37t28e/v+DTy48OHEixs/jjy58uXMmzt/Dj269OnUq1u/jj279u3cu3v/Dj68+PHky5s/jz69+vXs27t/Dz++/Pn069u/jz+//v38+/v//w9ggAIOSGCBBh6IYIIKLshggw4+CGGEEk5IYYUWXohhhhpuyGGHHn4IYogijkhiiSaeiGKKKq7IYosuvghjjDLOSGONNt6IY4467shjjz7+CGSQQg5JZJFGHolkkkouyWSTTj4JZZRSTklllVZeiWWWWm7JZZdefglmmGKOSWaZZp6JZppqrslmm26+CWeccs5JZ5123olnnnruyWeffv4JaKCCDkpooYYeimiiii7KaKOOPgpppJJOSmmlll6Kaaaabsppp55+Cmqooo5Kaqmmnopqqqquymqrrr4Ka6yyzkprrbbeimuuuu7Ka6++/gpssMIOS2yxxh6LbLLK/y7LbLPOPgtttNJOS2211l6Lbbbabsttt95+C2644o5Lbrnmnotuuuquy2677r4Lb7zyzktvvfbei2+++u7Lb7/+/gtwwAIPTHDBBh+McMIKL8xwww4/DHHEEk9MccUWX4xxxhpvzHHHHn8Mcsgij0xyySafjHLKKq/McssuvwxzzDLPTHPNNt+Mc84678xzzz7/DHTQQg9NdNFGH4100kovzXTTTj8NddRST0111VZfjXXWWm/Ndddefw122GKPTXbZZp+Ndtpqr812226/DXfccs9Nd91234133nrvzXfffv8NeOCCD0544YYfjnjiii/OeOOOPw555JJPTnnllv9fjnnmmm/Oeeeefw566KKPTnrppp+Oeuqqr856666/Dnvsss9Oe+2234577rrvznvvvv8OfPDCD0988cYfj3zyyi/PfPPOPw999NJPT3311l+Pffbab899995/D3744o9Pfvnmn49++uqvz3777r8Pf/zyz09//fbfj3/++u/Pf//+/w/AAApwgAQsoAEPiMAEKnCBDGygAx8IwQhKcIIUrKAFL4jBDGpwgxzsoAc/CMIQinCEJCyhCU+IwhSqcIUsbKELXwjDGMpwhjSsoQ1viMMc6nCHPOyhD38IxCAKcYhELKIRj4jEJCpxiUxsohOfCMUoSnGKVKyiFa+IxSz/anGLXOyiF78IxjCKcYxkLKMZz4jGNKpxjWxsoxvfCMc4ynGOdKyjHe+IxzzqcY987KMf/wjIQApykIQspCEPichEKnKRjGykIx8JyUhKcpKUrKQlL4nJTGpyk5zspCc/CcpQinKUpCylKU+JylSqcpWsbKUrXwnLWMpylrSspS1victc6nKXvOylL38JzGAKc5jELKYxj4nMZCpzmcxspjOfCc1oSnOa1KymNa+JzWxqc5vc7KY3vwnOcIpznOQspznPic50qnOd7GynO98Jz3jKc570rKc974nPfOpzn/zspz//CdCACnSgBC2oQQ+K0IQqdKEMbahDHwrRiEp0/6IUrahFL4rRjGp0oxztqEc/CtKQinSkJC2pSU+K0pSqdKUsbalLXwrTmMp0pjStqU1vitOc6nSnPO2pT38K1KAKdahELapRj4rUpCp1qUxtqlOfCtWoSnWqVK2qVa+K1axqdatc7apXvwrWsIp1rGQtq1nPita0qnWtbG2rW98K17jKda50ratd74rXvOp1r3ztq1//CtjACnawhC2sYQ+L2MQqdrGMbaxjHwvZyEp2spStrGUvi9nManaznO2sZz8L2tCKdrSkLa1pT4va1Kp2taxtrWtfC9vYyna2tK2tbW+L29zqdre87a1vfwvc4Ap3uMQtrnGPi9zkKne5zJNtrnOfC93oSne61K2uda+L3exqd7vc7a53vwve8Ip3vOQtr3nPi970qne97G2ve98L3/jKd770ra9974vf/Op3v/ztr3//C+AAC3jABC6wgQ+M4AQreMEMbrCDHwzhCEt4whSusIUvjOEMa3jDHO6whz8M4hCLeMQkLrGJT4ziFKt4xSxusYtfDOMYy3jGNMZFAQAAOw==" width="100%"/>
            
            
            
            <!--data-srcset="[{80:cropid},{160:cropid},..{1200:cropid}]" -->
            
        </figure>
        
        
        
    </xsl:template>
    
</xsl:stylesheet>