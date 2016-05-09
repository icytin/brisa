/**
 * Upload module main file 
 */
$(document).ready(function() {
	
	loadStatus();
	
	var $submitButton = $('button[type="submit"]');
	
	$submitButton.on('click', function(e) {
		
		e.preventDefault();
		e.stopPropagation();
		
		$('.result').html('');
		$('#progress').hide();
		$(this).removeAttr('disabled');
		if( $(this).parents('form').find('input[type="file"]').prop('files').length === 0) {
			return;
		}

		$('.progress').show();
		$(this).attr('disabled', 'disabled');
		loadStatus();
		
		var formData = new FormData($('#excelUploadForm')[0]);
	    $.ajax({
	        url: $('#modulePath').val() + '/excel',  //Server script to process data
	        type: 'POST',
	        xhr: function() {  // Custom XMLHttpRequest
	            var myXhr = $.ajaxSettings.xhr();
	            if(myXhr.upload){ // Check if upload property exists
	                myXhr.upload.addEventListener('progress', progressHandlingFunction, false); // For handling the progress of the upload
	            }
	            return myXhr;
	        },
	        //Ajax events
	        beforeSend: beforeSendHandler,
	        success: completeHandler,
	        error: errorHandler,
	        // Form data
	        data: formData,
	        //Options to tell jQuery not to process data or worry about content-type.
	        cache: false,
	        contentType: false,
	        processData: false,
	        async: true
	    });
	    
	    function beforeSendHandler() {
	    	
	    }
	    
	    function completeHandler() {
	    	
	    }
	    
	    function errorHandler() {
	    	
	    }
	    
	    function progressHandlingFunction(e){
	        if(e.lengthComputable){
	            $('#excelUploadForm .progress').attr({value:e.loaded,max:e.total});
	        }
	    }
	    
	});
	
    function loadStatus() {
    	
    	$('.result').removeClass('').addClass('result');
    	
		requestHandler.get({}, $('#modulePath').val() + '/getUploadStatus', true, undefined, function(res) {
			if(res.fileupload === 1) { // Success
    			$('.progress-bar').css('width', '100%');
    			setTimeout(function() {
	    			$('.progress-bar').css('width', '0');
	    			$('.progress-bar').attr('currentVal', 0);
	    			$('.result').addClass('success').html('Filen har l&auml;sts in med lyckat resultat!');
	    			$('.progress').hide();
	    			$submitButton.attr('disabled', 'disabled');
    			}, 1000);
			}
			else if(res.fileupload === 0) { // Fail
				$('.result').addClass('error').html('Den senaste filuppladdningen misslyckades!');
			}
			else { // No status set
				if($submitButton.attr('disabled')) { // if upload in progress
					setTimeout(function() {
			    		var cv = $('.progress-bar').attr('currentVal'),
		    				v = cv ? parseInt(cv) : 0;
		    				
	    				if(v <= 100) {
	    					$('.progress-bar').css('width', (v + 10) + '%');
	    				}
	    				
		    			$('.progress-bar').attr('currentVal', v);
		    			
		    			loadStatus();
		    			
					}, 1000);
				}
				else {
					$('.result').addClass('info').html('Ingen fil har laddats upp.');
				}
			}
		});
    };
	
});


