/**
 * Created by HP on 3/17/2015.
 */
var JSONRequest = tinymce.util.JSONRequest, each = tinymce.each, DOM = tinymce.DOM;
var walker = new tinymce.dom.TreeWalker('body');


tinymce.PluginManager.add('example', function(editor, url) {

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
    function escapeSeparators()
    {
        var escapedWSC = '',
            str = '\\s!#$%&()*+,-./:;<=>?@[\]^_{|}�\u201d\u201c';
        console.log(str);
        // Build word separator regexp
        for (var i=0; i<str.length; i++)
        {
            escapedWSC += '\\' + str.charAt(i);
        }
        console.log(escapedWSC);
        return escapedWSC;
    }
    function markWords(errors, errortype){

        each(errors, function(d)
        {
            var rl = [];
            var re = escapeSeparators(),w = "";
            var v = d["word"].replace(/\s+/g, '[' + re + ']');
            console.log(d);
            console.log(v);

            if (d["pre"] == "") {
                //console.log("Pre doint it: '" + v + "'");
                v =  '(?:(.{0})(' + v + ')(['+re+']*))';
                console.log(v);
                rl.push(new RegExp('^(?:(.{0})(' + v + ')(.{0}))', 'g'));
            } else {
                v = '(?:(' + d["pre"] + '[' + re + ']+)(' + v + ')(['+re+']))';
                console.log(v);
                rl.push(new RegExp(v, 'g'));
            }

            w += (w ? '|' : '') + v;
            console.log(w);
            var newContent =editor.getContent().replace(new RegExp(w, 'g'),"$1<span>$2</span>$3");

            console.log(editor.getBody().createTreeWalker);
            if(editor.getBody().createTreeWalker){
                var node = editor.getBody().createTreeWalker(n, NodeFilter.SHOW_TEXT, null, false);
                console.log(node);
                while(node){
                    node = node.nextNode();
                    console.log(node);
                }
            }

            console.log(newContent);
            //tinymce.activeEditor.setContent('<span><li>kjhh</li>ki</span>', {format: 'raw'});
        });
    }
    editor.addButton('example', {
        text: 'Review',
        icon: false,
        onclick: function() {
            var walker = new tinymce.dom.TreeWalker('p');

            do {
                console.log(walker.current());
            } while (walker.next());
            editor.suggestions = [];
            editor.setProgressState(1);
            ReviewRequest_XHR('../ATDWeb/request.php',editor.getContent(),function(xmlString) {
                console.log(xmlString);
                xmlString = $.parseXML(xmlString.substr(xmlString.indexOf('<'),xmlString.lastIndexOf('>')+1));

                var grammarErrors    = [];
                var spellingErrors   = [];
                var enrichment       = [];

                $(xmlString).find('error').each(function(key,value){
                    var errorString      = $(value).find('string').text();
                    var errorType        = $(value).find('type').text();
                    var errorDescription = $(value).find('description').text();
                    console.log($(value).find('precontext'));
                    var errorContext = ($(value).find('precontext') != undefined)?
                        $(value).find('precontext').text():"";

                    var suggestion = {};
                    suggestion["description"] = errorDescription;
                    suggestion["suggestions"] = [];
                    //suggestion["matcher"]     = new RegExp(errorString.replace(/\s+/, '[' + plugin._getSeparators() + ']'));
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

                markWords(spellingErrors,"hiddenGrammar")
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