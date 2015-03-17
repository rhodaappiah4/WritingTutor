/**
 * Created by HP on 3/17/2015.
 */
var JSONRequest = tinymce.util.JSONRequest, each = tinymce.each, DOM = tinymce.DOM;
//var walker = new tinymce.dom.TreeWalker('body');
function ReviewRequest_XHR(url,reqParam,success){

    tinymce.util.XHR.send({
        url: url+"?test=" + encodeURI(reqParam).replace(/&/g, '%26'),
        type: "GET",
        //data: "test=" + encodeURI(reqParam).replace(/&/g, '%26'),
       // content_type : "text/xml",
        success: success,
        error:function(type,req,o ){
            alert( type + "\n" + req.status + "\nAt: " + o.url );
        }
    });
}

tinymce.PluginManager.add('example', function(editor, url) {
    // Add a button that opens a window
   // ;
    editor.addButton('example', {
        text: 'My button',
        icon: false,
        onclick: function() {
            editor.suggestions = [];
            editor.setProgressState(1);
            ReviewRequest_XHR('../ATDWeb/request.php',editor.getContent(),function(xmlString) {
                console.log(xmlString);
                xmlString = $.parseXML(xmlString.substr(xmlString.indexOf('<'),xmlString.lastIndexOf('>')+1));

                var grammarErrors    = [];
                var spellingErrors   = [];
                var enrichment       = [];

                $(xmlString).find('worked').each(function(key,value){
                    var errorString      = $(value).find('string').text();
                    var errorType        = $(value).find('type').text();
                    var errorDescription = $(value).find('description').text();
                    var errorContext = ($(value).find('precontext') != null)?
                        $(value).find('precontext').text():"";

                    var suggestion = {};
                    suggestion["description"] = errorDescription;
                    suggestion["suggestions"] = [];
                    suggestion["matcher"]     = new RegExp(errorString.replace(/\s+/, '[' + plugin._getSeparators() + ']'));
                    suggestion["context"]     = errorContext;
                    suggestion["string"]      = errorString;
                    suggestion["type"]        = errorType;
                    editor.setProgressState(0);
                    console.debug($(value).find('inn').text());

                    if ($(value).find('suggestions') != undefined){
                        var suggestions =  $(value).find('suggestions').find('option');
                        for (j = 0; j < suggestions.length; j++){
                            suggestion["suggestions"].push($(suggestions[j]).text());
                        }
                    }

                    //TODO: setup url for explanation
                    //* setup the more info url */
                    //if (errors[i].getElementsByTagName('url').item(0) != undefined)
                    //{
                    //    var errorUrl = errors[i].getElementsByTagName('url').item(0).firstChild.data;
                    //    var theme    = editor.getParam("atd_theme", "tinymce");
                    //    suggestion["moreinfo"] = errorUrl + '&theme=' + theme;
                    //    //console.log(errorUrl);
                    //}

                    editor.suggestions.push(suggestion);
                    if (errorType == "suggestion")
                        enrichment.push({ word: errorString, pre: errorContext });

                    if (errorType == "grammar")
                        grammarErrors.push({ word: errorString, pre: errorContext });

                    if (errorType == "spelling" || errorDescription == "Homophone")
                        spellingErrors.push({ word: errorString, pre: errorContext });
                });

            });
            // Open window
            editor.windowManager.open({
                title: 'Example plugin',
                body: [
                    {type: 'textbox', name: 'title', label: 'Title'}
                ],
                onsubmit: function(e) {
                    // Insert content when the window form is submitted
                    editor.insertContent('Title: ' + e.data.title);
                }
            });
        }
    });

    // Adds a menu item to the tools menu
    editor.addMenuItem('example', {
        text: 'Example plugin',
        context: 'tools',
        onclick: function() {
            // Open window with a specific url
            editor.windowManager.open({
                title: 'TinyMCE site',
                url: 'http://www.tinymce.com',
                width: 800,
                height: 600,
                buttons: [{
                    text: 'Close',
                    onclick: 'close'
                }]
            });
        }
    });
});