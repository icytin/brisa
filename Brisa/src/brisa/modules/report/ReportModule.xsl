<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" />
  
  <xsl:template match="document">
  	<link rel="stylesheet" href="{/document/requestinfo/contextpath}/static/f/{/document/module/sectionID}/{/document/module/moduleID}/css/main.css"></link>
  	
    <!-- module path -->
    <input id="modulePath" type="hidden" value="{/document/requestinfo/currentURI}/{/document/module/alias}/"></input>
    
    <section class="report">
    	<h1><i class="glyphicon glyphicon-stats"></i>Rapport</h1>
    	
    	<div class="links">
    		<a onclick="alert('pdf')" class="pdf"><img src="{/document/requestinfo/contextpath}/static/f/{/document/module/sectionID}/{/document/module/moduleID}/img/pdf-icon.png"></img></a>
    		<a onclick="alert('excel')" class="excel"><img src="{/document/requestinfo/contextpath}/static/f/{/document/module/sectionID}/{/document/module/moduleID}/img/excel-icon.png"></img></a>
    	</div>
    	
    </section>
    
    <script type="text/javascript" src="{/document/requestinfo/contextpath}/static/f/{/document/module/sectionID}/{/document/module/moduleID}/js/main.js"></script>
  </xsl:template>
  
</xsl:stylesheet>