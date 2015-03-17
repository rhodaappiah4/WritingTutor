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
            editor.setProgressState(1);
            ReviewRequest_XHR('../ATDWeb/request.php',editor.getContent(),function(xmlString) {
                console.log(xmlString);
                xmlString = $.parseXML(xmlString.substr(xmlString.indexOf('<'),xmlString.lastIndexOf('>')+1));
                $(xmlString).find('worked').each(function(key,value){
                    console.debug($(value).find('inn').text());

                });
                editor.setProgressState(0);
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