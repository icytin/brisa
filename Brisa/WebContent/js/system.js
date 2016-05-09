$(function () {
	
  // Menu toggle button
  $('[data-toggle="offcanvas"]').click(function () {
    $('.row-offcanvas').toggleClass('active');
  });
  
  $(".navbar-toggle").on("click", function () {
	  $(this).toggleClass("active");
  });
});


/**
 * =====================================================================
 * Global Libraries
 * =====================================================================
 */

var requestHandler = function () {

    var self;
    
    /*
    * Does a request with the specified parameters. Returns the data as JSON on success, otherwise undefined.
    *
    * # TypeOfRequest: GET or POST
    * # Params: An array with parameters
    * # url: The request url
    * # async: If the call should be asynced or not. Default is async = false.
    * # traditional: As of jQuery 1.4, the $.param() method serializes deep objects recursively to accommodate modern scripting 
    * languages and frameworks such as PHP and Ruby on Rails.You can disable this functionality globally by setting 
    * jQuery.ajaxSettings.traditional = true;. Default is undefined.
    * # successFuntion: An optional callback function to be triggered on success. 
    *
    * Example (MVC):
    * var response = requestHandler.post({ id: $(this).val() }, '@Url.Action("GetInformation", "Controller")')
    */
    var _doRequest = function (typeOfRequest, params, url, async, traditional, successFunction) {

        var o = undefined;
        async = async === undefined ? false : async;
        if (!async) { // If synchronized, we block the UI
            // $.blockUI();
        }

        $.ajax({
            cache: false,
            type: typeOfRequest,
            url: url,
            data: params,
            success: function (data) {
                o = data;
                if (successFunction) {
                    successFunction(data);
                }
            },
            error: function (data, q, t) {
                // Show failure.. dialog or something..
                // $.unblockUI();
            },
            async: async,
            traditional: traditional
        });

        return o; // Undefined on failure
    }

    $(function () {
        $.ajaxSetup({
            async: false
        });
    });

    return {
      // Post request
      post: function(params, url, async, traditional, successFunction) {
        return _doRequest('POST', params, url, async, traditional, successFunction);
      },
      // Get request
      get: function(params, url, async, traditional, successFunction) {
        return _doRequest('GET', params, url, async, traditional, successFunction);
      }
    };
}(jQuery);