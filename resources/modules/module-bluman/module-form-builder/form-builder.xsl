<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all"
  xmlns="http://www.w3.org/1999/xhtml" version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:portal="http://www.enonic.com/cms/xslt/portal"
  xmlns:stk="http://www.enonic.com/cms/xslt/stk">    
  
  <xsl:import href="/modules/library-stk/stk-variables.xsl"/>
  <xsl:import href="/modules/library-stk/html.xsl"/>
  
  <xsl:output method="xhtml"/>
  
  <xsl:variable name="current-menuitem" select="/result/menuitems/menuitem"/>
  <xsl:variable name="form" select="$current-menuitem/data/form"/>
  <xsl:variable name="form-id" select="$current-menuitem/@key"/>
  <xsl:variable name="error" as="element()*" select="$stk:querystring-parameter[@name = 'error_form_create']"/>
  
  <xsl:template match="/">
    <div class="form-builder">
      <h1>
        <xsl:value-of select="$stk:current-resource/display-name"/>
      </h1>
      <xsl:choose>
        <!-- Form submit success -->
        <xsl:when test="$stk:querystring-parameter[@name = 'success'] = 'create'">
          <xsl:call-template name="stk:html.process">
            <xsl:with-param name="document" select="$current-menuitem/data/form/confirmation"/>
          </xsl:call-template>
        </xsl:when>
        <!-- Form submit error -->
        <xsl:when test="$error and /result/context/session/attribute[@name = 'error_form_create']/content/contentdata/form">
          <xsl:call-template name="display-form">
            <xsl:with-param name="form" select="/result/context/session/attribute[@name = 'error_form_create']/content/contentdata/form"/>
            <xsl:with-param name="error-handling" select="true()" tunnel="yes"/>
          </xsl:call-template>
        </xsl:when>
        <!-- Display form -->
        <xsl:otherwise>
          <xsl:call-template name="display-form">
            <xsl:with-param name="form" select="$current-menuitem/data/form"/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:call-template name="javascript"/>
    </div>
  </xsl:template>

  <xsl:template name="display-form">
    <xsl:param name="form" as="element()"/>
    <xsl:param name="error-handling" as="xs:boolean" select="false()" tunnel="yes"/>
    <xsl:call-template name="stk:html.process">
      <xsl:with-param name="document" select="$current-menuitem/document"/>
    </xsl:call-template>
    <form action="{portal:createServicesUrl('form', 'create', portal:createPageUrl(('success', 'create')), ())}" enctype="multipart/form-data" method="post">
      <fieldset>
          <legend>
            <xsl:value-of select="$form/title"/>
          </legend>
          <xsl:if test="$error">
            <div class="error">
              <xsl:for-each select="$error">
                <xsl:value-of select="portal:localize(concat('user-error-', .))"/>
                <xsl:if test="position() != last()">
                  <br/>
                </xsl:if>
              </xsl:for-each>
            </div>
          </xsl:if>
          <input name="_form_id" type="hidden" value="{$form-id}"/>
          <input name="categorykey" type="hidden" value="{$form/@categorykey}"/>
          <xsl:for-each select="$form/recipients/e-mail">
            <input name="{concat($form-id, '_form_recipient')}" type="hidden" value="{.}"/>
          </xsl:for-each>
          <xsl:apply-templates select="$form/item"/>
          
          <xsl:call-template name="captcha"/>
        
      </fieldset>
      <div class="actions">
        <input type="submit" class="submit" value="{portal:localize('form-builder.submit')}"/>
        <input type="reset" class="reset" value="{portal:localize('form-builder.reset')}"/>
      </div>
    </form>
  </xsl:template>

  <xsl:template match="item">
    <xsl:param name="error-handling" as="xs:boolean" select="false()" tunnel="yes"/>
    <xsl:variable name="input-id" select="concat('form_', $form-id, '_elm_', position())"/>
    <xsl:variable name="input-name" select="concat($form-id, '_form_', position())"/>
          
      <fieldset class="item">
          <label>
            <xsl:attribute name="for">
              <xsl:value-of select="$input-id"/>
              <xsl:if test="@type = 'radiobuttons' or @type = 'checkboxes'">
                <xsl:text>_1</xsl:text>                
              </xsl:if>
            </xsl:attribute>
            <xsl:if test="@required = 'true'">
              <xsl:attribute name="class" select="'required'"/>
            </xsl:if>
            <xsl:choose>
              <xsl:when test="normalize-space(help)">
                <span class="tooltip" title="{help}">
                  <xsl:value-of select="@label"/>              
                </span>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="@label"/>
              </xsl:otherwise>
            </xsl:choose>
          </label>
        
        <div class="input">
          <!-- this container is needed because of limited styling capabilities on input elements (i.e. table-cell) --> 
          
          <xsl:choose>   
            <!-- Checkbox -->
            <xsl:when test="@type = 'checkbox'">
              <label for="{$input-id}" class="checkbox">
                <input id="{$input-id}" name="{$input-name}" type="{@type}" class="checkbox{if (help) then ' tooltip' else ''}{if (error) then ' error' else ''}{if (@required = 'true') then ' required' else ''}">
                  <xsl:if test="help">
                    <xsl:attribute name="title">
                      <xsl:value-of select="help"/>
                    </xsl:attribute>
                  </xsl:if>
                  <xsl:if test="data = 'on' or (empty(data) and @default = 'checked')">
                    <xsl:attribute name="checked">checked</xsl:attribute>
                  </xsl:if>
                </input>
              </label>
            </xsl:when>
            
            <!-- Text box -->
            <xsl:when test="@type = 'text'">
              <input class="{if (help) then 'text tooltip' else 'text'}{if (error) then ' error' else ''}{if (@required = 'true') then ' required' else ''}{if (@validationtype = 'integer') then ' digits' else ''}{if (@validationtype = 'email') then ' email' else ''}" id="{$input-id}" name="{$input-name}" type="text">
                <xsl:if test="help">
                  <xsl:attribute name="title">
                    <xsl:value-of select="help"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="data">
                  <xsl:attribute name="value">
                    <xsl:value-of select="data"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="@width and $stk:device-class != 'mobile'">
                  <xsl:attribute name="style">
                    <xsl:value-of select="concat('width: ', @width, 'px;')"/>
                  </xsl:attribute>
                </xsl:if>
              </input>
            </xsl:when>
            <!-- Textarea -->
            <xsl:when test="@type = 'textarea'">
              <textarea rows="6" cols="30" id="{$input-id}" name="{$input-name}">
                <xsl:if test="help or error or @required = 'true'">
                  <xsl:attribute name="class">
                    <xsl:if test="help">
                      <xsl:text>tooltip</xsl:text>
                    </xsl:if>
                    <xsl:if test="error">
                      <xsl:text> error</xsl:text>
                    </xsl:if>
                    <xsl:if test="@required = 'true'">
                      <xsl:text> required</xsl:text>
                    </xsl:if>
                  </xsl:attribute>
                  <xsl:if test="help">
                    <xsl:attribute name="title">
                      <xsl:value-of select="help"/>
                    </xsl:attribute>
                  </xsl:if>
                </xsl:if>
                <xsl:if test="(@width and $stk:device-class != 'mobile') or @height">
                  <xsl:attribute name="style">
                    <xsl:if test="@width and $stk:device-class != 'mobile'">
                      <xsl:value-of select="concat('width: ', @width, 'px;')"/>
                    </xsl:if>
                    <xsl:if test="@height">
                      <xsl:value-of select="concat('height: ', @height, 'px;')"/>
                    </xsl:if>
                  </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="data"/>
              </textarea>
            </xsl:when>
            <!-- Checkboxes -->
            <xsl:when test="@type = 'checkboxes'">
              <xsl:for-each select="data/option">
                <xsl:variable name="id" select="concat($input-id, '_', position())"/>
                <label for="{$id}">
                  <xsl:attribute name="class">
                    <xsl:text>checkbox</xsl:text>
                    <xsl:if test="position() = last()">
                      <xsl:text> last</xsl:text>
                    </xsl:if> 
                  </xsl:attribute>
                  
                  <input id="{$id}" name="{$input-name}" type="checkbox" class="checkbox" value="{@value}">
                    <xsl:if test="(not($error-handling) and @default = 'true') or ($error-handling and @selected = 'true')">
                      <xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:if>
                  </input>
                  <xsl:value-of select="@value"/>
                </label>
              </xsl:for-each>
            </xsl:when>
            <!-- Radio buttons -->
            <xsl:when test="@type = 'radiobuttons'">
              <xsl:for-each select="data/option">
                <xsl:variable name="id" select="concat($input-id, '_', position())"/>
                <label for="{$id}">
                  <xsl:attribute name="class">
                    <xsl:text>radio</xsl:text>
                    <xsl:if test="position() = last()">
                      <xsl:text> last</xsl:text>
                    </xsl:if>   
                  </xsl:attribute>
                  
                  <input id="{$id}" name="{$input-name}" type="radio" value="{@value}">
                    <xsl:attribute name="class">
                      <xsl:text>radio</xsl:text>
                      <xsl:if test="position() = 1 and ../../@required = 'true'">
                        <xsl:text> required</xsl:text>                  
                      </xsl:if>
                    </xsl:attribute>
                    
                    <xsl:if test="(not($error-handling) and @default = 'true') or ($error-handling and @selected = 'true')">
                      <xsl:attribute name="checked">checked</xsl:attribute>
                    </xsl:if>
                  </input>
                  <xsl:value-of select="@value"/>
                </label>
              </xsl:for-each>
            </xsl:when>
            <!-- Dropdown -->
            <xsl:when test="@type = 'dropdown'">
              <div class="styled-select">
                <select id="{$input-id}" name="{$input-name}">
                  <xsl:if test="help or error or @required = 'true'">
                    <xsl:attribute name="class">
                      <xsl:if test="help">
                        <xsl:text>tooltip</xsl:text>
                      </xsl:if>
                      <xsl:if test="error">
                        <xsl:text> error</xsl:text>
                      </xsl:if>
                      <xsl:if test="@required = 'true'">
                        <xsl:text> required</xsl:text>
                      </xsl:if>
                    </xsl:attribute>
                    <xsl:if test="help">
                      <xsl:attribute name="title">
                        <xsl:value-of select="help"/>
                      </xsl:attribute>
                    </xsl:if>
                  </xsl:if>
                  <xsl:if test="not(@required = 'true')">
                    <option value="">
                      <xsl:value-of select="portal:localize('form-builder.select')"/>
                    </option>
                  </xsl:if>
                  <xsl:for-each select="data/option">
                    <option value="{@value}">
                      <xsl:if test="(not($error-handling) and @default = 'true') or ($error-handling and @selected = 'true')">
                        <xsl:attribute name="selected">selected</xsl:attribute>
                      </xsl:if>
                      <xsl:value-of select="@value"/>
                    </option>
                  </xsl:for-each>
                </select>
              </div>              
            </xsl:when>
            <!-- File attachment -->
            <xsl:when test="@type = 'fileattachment'">
              <input class="{if (help) then 'text tooltip' else 'text'}{if (error) then ' error' else ''}{if (@required = 'true') then ' required' else ''}" id="{$input-id}" name="{$input-name}" type="file">
                <xsl:if test="help">
                  <xsl:attribute name="title">
                    <xsl:value-of select="help"/>
                  </xsl:attribute>
                </xsl:if>
                <xsl:if test="data">
                  <xsl:attribute name="value">
                    <xsl:value-of select="data"/>
                  </xsl:attribute>
                </xsl:if>
              </input>
            </xsl:when>
          </xsl:choose>
          
          <!-- Error handling -->
          <xsl:if test="error">
            <div class="error">
              <xsl:choose>
                <xsl:when test="error[@id = 1]">
                  <xsl:value-of select="portal:localize('form-builder.validate.required')"/>
                </xsl:when>
                <xsl:when test="error[@id = 2]">
                  <xsl:choose>
                    <xsl:when test="@validationtype = 'email'">
                      <xsl:value-of select="portal:localize('form-builder.validate.email')"/>
                    </xsl:when>
                    <xsl:when test="@validationtype = 'integer'">
                      <xsl:value-of select="portal:localize('form-builder.validate.digits')"/>
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="portal:localize('form-builder.validate.custom-regexp')"/>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:when>
              </xsl:choose>
            </div>
          </xsl:if>  
          
        </div>
        
      </fieldset>
      
    
    
    <xsl:if test="@title = 'true'">
      <input name="{concat($form-id, '_form_title')}" type="hidden" value="{$input-id}"/>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="item[@type = 'separator']">
    <!-- Separator -->
      <div class="{if (help) then 'separator tooltip' else 'separator'}">
        <xsl:if test="help">
          <xsl:attribute name="title">
            <xsl:value-of select="help"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:value-of select="@label"/>
      </div>    
  </xsl:template>
  
  <xsl:template name="javascript">
    <script type="text/javascript">
      // Reloads captcha image
      function reloadCaptcha(imageId) {
        var src = document.getElementById(imageId).src;
        document.getElementById(imageId).src = src.split('?')[0] + '?' + (new Date()).getTime();
      }  
    </script>
  </xsl:template>
  
  <xsl:template name="captcha">
    <xsl:if test="portal:isCaptchaEnabled('content', 'create') and not($stk:user)">
      <div class="captcha">
        <p>
          <xsl:value-of select="portal:localize('stk.captcha.instructions')"/>
        </p>
        <img src="{portal:createCaptchaImageUrl()}" alt="{portal:localize('stk.captcha.image')}" id="formbuilder-captcha-image" class="captcha-image"/>
        <a href="#" onclick="reloadCaptcha('formbuilder-captcha-image');return false;" class="new-captcha-image">
          <xsl:value-of select="portal:localize('stk.captcha.new-image')"/>
        </a>
        <xsl:if test="$error = 405">
          <label class="error">
            <xsl:value-of select="portal:localize('user-error-405')"/>
          </label>
        </xsl:if>
        <label for="formbuilder-captcha">
          <span class="tooltip" title="{concat(portal:localize('stk.captcha.repeat-text'), ' - ', portal:localize('stk.captcha.help-text'))}">
            <xsl:value-of select="portal:localize('stk.captcha.validation')"/>
          </span>
        </label>
        <input type="text" id="formbuilder-captcha" name="{portal:createCaptchaFormInputName()}">
          <xsl:attribute name="class">
            <xsl:text></xsl:text>  
          </xsl:attribute>
          <xsl:attribute name="title" select="concat(portal:localize('stk.captcha.repeat-text'), ' - ', portal:localize('stk.captcha.help-text'))"/>
            
<!--          
          class="text required tooltip{if ($error = 405) then ' error' else ''}" title="{}"-->
        </input> 
     </div>
    </xsl:if>
  </xsl:template>
  
</xsl:stylesheet>