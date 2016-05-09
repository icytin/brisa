/**
 * Index module main file 
 */
$(document).ready(function() {
	
	var modulePath = $('#modulePath').val();
	
	requestHandler.get({},  modulePath + 'getSurveyData', true, undefined, function(result) {
		// TODO: Handle result
		$('section.surveyData p.info').html('Kunde inte hitta n&aring;gon enk&auml;tdata.');
		
	});
});
