<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" />
  
  <xsl:template match="document">
  	<link rel="stylesheet" href="{/document/requestinfo/contextpath}/static/f/{/document/module/sectionID}/{/document/module/moduleID}/css/main.css"></link>
  	
    <!-- module path -->
    <input id="modulePath" type="hidden" value="{/document/requestinfo/currentURI}/{/document/module/alias}/"></input>
    
    <section class="connect">
    	<h1><i class="glyphicon glyphicon-transfer"></i>Koppla</h1>
    	
    </section>
    
    <script type="text/javascript" src="{/document/requestinfo/contextpath}/static/f/{/document/module/sectionID}/{/document/module/moduleID}/js/main.js"></script>
  </xsl:template>
  
</xsl:stylesheet>