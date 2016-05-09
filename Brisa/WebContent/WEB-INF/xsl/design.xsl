<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="ISO-8859-1" indent="yes" />
  
  <xsl:include href="classpath://se/unlogic/hierarchy/core/xsl/CommonCoreTemplates.xsl" />
  <xsl:include href="classpath://se/unlogic/hierarchy/core/xsl/Errors.sv.xsl" />
  
  <xsl:template match="document">
    <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
    <xsl:comment><![CDATA[[if lt IE 8]>      <html class="no-js lt-ie9 lt-ie8"> <![endif]]]></xsl:comment>
    <xsl:comment><![CDATA[[if IE 8]>         <html class="no-js lt-ie9"> <![endif]]]></xsl:comment>
    <xsl:comment><![CDATA[[if gt IE 8]><!]]></xsl:comment>
    <html class="no-js" lang="sv">
    <xsl:comment><![CDATA[<![endif]]]></xsl:comment>
    <head>
      <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
      
      <title>
      	<xsl:text>Brisa</xsl:text>
      	<xsl:if test="title">
          <xsl:text> - </xsl:text>
          <xsl:value-of select="title" />
      	</xsl:if>
      </title>
      
      <link rel="stylesheet" href="{/document/requestinfo/contextpath}/css/bootstrap.min.css"></link>
      <link rel="stylesheet" href="{/document/requestinfo/contextpath}/css/bootstrap-theme.min.css" ></link>
      
      <!-- Openhierarchy styles -->
      <link href="{/document/requestinfo/contextpath}/css/openhierarchy.css" rel="stylesheet" type="text/css" media="screen,projection"></link>
      
      <link rel="stylesheet" href="{/document/requestinfo/contextpath}/css/styles.css"></link>
      
      <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
      <xsl:comment><![CDATA[[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]]]></xsl:comment>
      
      <xsl:apply-templates select="links/link" />
      
      <script src="{/document/requestinfo/contextpath}/js/jquery.min.js"></script>
      <script src="{/document/requestinfo/contextpath}/js/bootstrap.min.js"></script>
      <script src="{/document/requestinfo/contextpath}/js/system.js"></script>
      <xsl:apply-templates select="scripts/script" />
	</head>
	<body class="non-responsive">
      <xsl:comment><![CDATA[[if lt IE 9]>
          <div class="outdated-browser">
            <p>
              Din webbläsare är <em>väldigt</em> gammal. Den är så pass gammal att den här webbplatsen inte kommer att fungera riktigt som den ska. På <a href="http://browsehappy.com/">browsehappy.com</a> kan du få hjälp med att uppgradera din webbläsare och förbättra upplevelsen.
            </p>
          </div>
        <![endif]]]></xsl:comment>
      
      <xsl:call-template name="page" />
    </body>
    </html>
  </xsl:template>
  
   <xsl:template name="page">
    <xsl:call-template name="header" />
    
    <xsl:call-template name="content" />
    
    <xsl:call-template name="footer" />
  </xsl:template>
  
  <xsl:template name="header">
    <!-- Fixed navbar -->
	<div class="navbar navbar-fixed-top">
	  <div class="navbar-header">
	    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
	      <span class="icon-bar"></span>
	      <span class="icon-bar"></span>
	      <span class="icon-bar"></span>
	    </button>
	    <a class="navbar-brand" href="{/document/requestinfo/contextpath}/">Brisa</a>
	  </div>
	  <div class="navbar-collapse collapse">
	    <ul class="nav navbar-nav">
      		<!--<li class="active"><a href="#">Home</a></li>
      		<li><a href="#about">About</a></li>
            <li><a href="{/document/requestinfo/contextpath}/kontakt">Kontakt</a></li>-->
	    </ul>
        <ul class="nav navbar-nav navbar-right">
            <xsl:if test="user/admin = 'true'"><li><a href="{/document/requestinfo/contextpath}/sysadmin">Systemadmin</a></li></xsl:if>
            <li><a href="{/document/requestinfo/contextpath}/logout">Logga ut</a></li>
          </ul>
	  </div>
	</div>

  </xsl:template>
  
  <xsl:template name="content">
    <div id="mainContainer" class="container">
      <div class="row row-offcanvas row-offcanvas-left active">
        <xsl:call-template name="submenu" />
        
        <div class="col-md-12 container theme-showcase" role="main">
        <xsl:if test="menus/menu/menuitem[itemType!='SECTION'] or menus/menu/menuitem/menu"><xsl:attribute name="class">col-md-9 container theme-showcase</xsl:attribute></xsl:if>
    
          <!-- Main jumbotron for a primary marketing message or call to action -->
          <div>
            <xsl:apply-templates select="errors"/>
            <xsl:value-of select="moduleHTMLResponse" disable-output-escaping="yes"/>
            <xsl:value-of select="moduleTransformedResponse" disable-output-escaping="yes"/>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template name="footer">
  	<footer class="footer">
      <div class="container">
        <p class="text-muted credit">Copyright Brisa® 2015 | Utvecklat i samarbete med <a href="http://www.cgi.se">CGI Sverige AB</a></p>
      </div>
    </footer>
  </xsl:template>
  
  <xsl:template name="submenu">
    <xsl:choose>
      <xsl:when test="not(menus/menu/menuitem/menu)">
        <div class="col-md-3 sidebar-offcanvas" id="sidebar" role="navigation">
          <div class="list-group">
            <xsl:apply-templates select="menus/menu/menuitem[itemType!='SECTION']"/>
          </div>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <div class="col-md-3 sidebar-offcanvas" id="sidebar" role="navigation">
          <div class="list-group">
            <xsl:apply-templates select="menus/menu/menuitem/menu"/>
          </div>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="menuitem" mode="sections">
      <xsl:if test="starts-with(/document/requestinfo/uri, concat(/document/requestinfo/contextpath, url))">
        <xsl:attribute name="class">active</xsl:attribute>
      </xsl:if>
      <a class="list-group-item">
        <xsl:choose>
          <xsl:when test="urlType='RELATIVE_FROM_CONTEXTPATH'">
            <xsl:attribute name="href"><xsl:value-of
              select="/document/requestinfo/contextpath" /><xsl:value-of
              select="url" /></xsl:attribute>
          </xsl:when>
          <xsl:when test="urlType='FULL'">
            <xsl:attribute name="href"><xsl:value-of select="url" /></xsl:attribute>
          </xsl:when>
        </xsl:choose>

        <xsl:value-of select="name" />
      </a>
  </xsl:template>
  
  <xsl:template match="menuitem">
    <xsl:variable name="menuLevel" select="count(../preceding-sibling::menuitems)" />
    
    <!-- Add indentation padding if child -->
    <xsl:variable name="padding-left">
      <xsl:choose>
        <xsl:when test="$menuLevel > 1">
          <xsl:value-of select="($menuLevel - 1) * 10" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="0" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:choose>
      <xsl:when test="itemType='BLANK'">
        <xsl:if test="position() != 1 and (preceding-sibling::menuitem[position()=1]/itemType = 'MENUITEM' or (preceding-sibling::menuitem[position()=1]/itemType = 'SECTION' and $menuLevel > 0) or ($menuLevel > 1 and preceding-sibling::menuitem[position()=1]/itemType = 'TITLE'))">
          <xsl:text disable-output-escaping="yes"><![CDATA[</ul>]]></xsl:text>
        </xsl:if>
        <xsl:choose>
          <xsl:when test="1 > $menuLevel">
            <br />
          </xsl:when>
          <xsl:otherwise>
            <hr class="noscreen" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <xsl:when test="itemType='MENUITEM' or itemType='SECTION' or (itemType='TITLE' and $menuLevel > 1)">
        <!-- 
        <xsl:if test="position() = 1 or (preceding-sibling::menuitem[position()=1]/itemType != 'MENUITEM' and (preceding-sibling::menuitem[position()=1]/itemType != 'SECTION' or (preceding-sibling::menuitem[position()=1]/itemType = 'SECTION' and $menuLevel = 0)) and not($menuLevel > 1 and preceding-sibling::menuitem[position()=1]/itemType = 'TITLE'))">
          <xsl:choose>
            <xsl:when test="$menuLevel > 1">
              <xsl:text disable-output-escaping="yes"><![CDATA[<ul class="nested">]]></xsl:text>
            </xsl:when>
            <xsl:otherwise>
              <xsl:text disable-output-escaping="yes"><![CDATA[<ul>]]></xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if> -->
        
          <xsl:choose>
            <xsl:when test="url">
              <a class="list-group-item">
                <!-- Add active as class if current page -->
                <xsl:if test="(itemType='SECTION' and ../following-sibling::menuitems[position()=1]/@sectionID=subSectionID) or 
                              (itemType='MENUITEM' and url and ((urlType='RELATIVE_FROM_CONTEXTPATH' and 
                                  string-length(concat(/document/requestinfo/contextpath,url)) = string-length(/document/requestinfo/uri) and
                                  starts-with(concat(/document/requestinfo/contextpath,url),/document/requestinfo/uri)) or
                              (urlType='FULL' and string-length(url) = string-length(/document/requestinfo/url) and starts-with(url,/document/requestinfo/url)))) or
                              /document/breadcrumbs/breadcrumb[last()]/url = url">
                  <xsl:attribute name="class">
                    <xsl:text>list-group-item active</xsl:text>
                  </xsl:attribute>
                </xsl:if>
                
                <xsl:choose>
                  <xsl:when test="urlType='RELATIVE_FROM_CONTEXTPATH'">
                    <xsl:attribute name="href">
                      <xsl:value-of select="/document/requestinfo/contextpath" />
                      <xsl:value-of select="url" />
                    </xsl:attribute>
                  </xsl:when>
                  <xsl:when test="urlType='FULL'">
                    <xsl:attribute name="href">
                      <xsl:value-of select="url" />
                    </xsl:attribute>
                  </xsl:when>
                </xsl:choose>
                <span><xsl:value-of select="name" /></span>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="name" />
            </xsl:otherwise>
          </xsl:choose>
        <!-- 
        <xsl:if test="position() = last()">
          <xsl:text disable-output-escaping="yes"><![CDATA[</ul>]]></xsl:text>
        </xsl:if> -->
      </xsl:when>

      <xsl:when test="itemType='TITLE'">
        <xsl:if
          test="position() != 1 and (preceding-sibling::menuitem[position()=1]/itemType = 'MENUITEM' or (preceding-sibling::menuitem[position()=1]/itemType = 'SECTION' and $menuLevel > 0) or ($menuLevel > 1 and preceding-sibling::menuitem[position()=1]/itemType = 'TITLE'))">
          <xsl:text disable-output-escaping="yes"><![CDATA[</ul>]]></xsl:text>
        </xsl:if>

        <xsl:choose>
          <xsl:when test="url">
            <a title="{../description}">
              <xsl:choose>
                <xsl:when test="urlType='RELATIVE_FROM_CONTEXTPATH'">
                  <xsl:attribute name="href">
                      <xsl:value-of select="/document/requestinfo/contextpath" />
                      <xsl:value-of select="url" />
                    </xsl:attribute>
                </xsl:when>
                <xsl:when test="urlType='FULL'">
                  <xsl:attribute name="href">
                      <xsl:value-of select="url" />
                    </xsl:attribute>
                </xsl:when>
              </xsl:choose>
              <xsl:value-of select="name" />
            </a>
          </xsl:when>
          <xsl:otherwise>
            <!-- Header disabled for submenu -->
            <!-- <h3><xsl:value-of select="name" /></h3> -->
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>

      <xsl:otherwise>
        <xsl:if test="position() != 1 and (preceding-sibling::menuitem[position()=1]/itemType = 'MENUITEM' or (preceding-sibling::menuitem[position()=1]/itemType = 'SECTION' and $menuLevel > 0) or ($menuLevel > 1 and preceding-sibling::menuitem[position()=1]/itemType = 'TITLE'))">
          <xsl:text disable-output-escaping="yes"><![CDATA[</ul>]]></xsl:text>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>

    <xsl:if test="itemType='SECTION' and ../following-sibling::menuitems[position()=1]/@sectionID=subSectionID and count(../following-sibling::menuitems[position()=1]/menuitem) > 0">
      <li>
        <xsl:apply-templates select="../following-sibling::menuitems[position()=1]/menuitem" />
      </li>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>