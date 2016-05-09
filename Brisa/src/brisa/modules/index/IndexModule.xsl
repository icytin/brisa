<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" />
  
  <xsl:template match="document">
  	<link rel="stylesheet" href="{/document/requestinfo/contextpath}/static/f/{/document/module/sectionID}/{/document/module/moduleID}/css/main.css"></link>
  	
    <!-- module path -->
    <input id="modulePath" type="hidden" value="{/document/requestinfo/currentURI}/{/document/module/alias}/"></input>
    
    <section class="surveyData">
    	<h1><i class="glyphicon glyphicon-list-alt"></i>Enkätdata</h1>
    	<p class="info"><strong>Laddar...</strong></p>
    </section>
    
    <script type="text/javascript" src="{/document/requestinfo/contextpath}/static/f/{/document/module/sectionID}/{/document/module/moduleID}/js/main.js"></script>
  </xsl:template>
  
</xsl:stylesheet>