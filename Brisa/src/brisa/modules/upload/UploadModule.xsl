<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="utf-8" indent="yes" />
  
  <xsl:template match="document">
  	<link rel="stylesheet" href="{/document/requestinfo/contextpath}/static/f/{/document/module/sectionID}/{/document/module/moduleID}/css/main.css"></link>
    
    <section class="fileupload">
    	<h1><i class="glyphicon glyphicon-upload"></i>Ladda upp fil</h1>
    	<input id="modulePath" type="hidden" value="{/document/requestinfo/currentURI}/{/document/module/alias}"></input> 
    	<form id="excelUploadForm" action="{/document/requestinfo/currentURI}/{/document/module/alias}/excel" method="post" enctype="multipart/form-data">
			<input type="file" name="fl_upload" class="file form-control"></input>
			<div class="row">
				<div class="col-lg-12">
					<div class="progress" style="display: none;">
						<div class="progress-bar" role="progressbar">
					    	<span class="sr-only"></span>
					  	</div>
					</div>
					<div class="result">
						
					</div>
				</div>
				<div class="col-lg-12 pull-right" style="text-align: right">
					<button type="reset" value="cancel" class="reset btn btn-default">Rensa</button>
					<button type="submit" value="Upload" class="submit btn btn-primary">Ladda upp</button>
				</div>
			</div>
		</form>
    </section>
    
    <script type="text/javascript" src="{/document/requestinfo/contextpath}/static/f/{/document/module/sectionID}/{/document/module/moduleID}/js/main.js"></script>
    
  </xsl:template>
  
</xsl:stylesheet>