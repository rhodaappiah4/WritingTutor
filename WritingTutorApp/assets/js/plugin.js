/**
 * Created by HP on 3/17/2015.
 */
var JSONRequest = tinymce.util.JSONRequest, each = tinymce.each, DOM = tinymce.DOM;
var walker = new tinymce.dom.TreeWalker('body');


tinymce.PluginManager.add('WritingTutor', function(editor, url) {

    function Request_XHR(url,reqParam,success){

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
    function escapeSeparators() {
        var escapedWSC = '',
            str = '\\s!#$%&()*+,-./:;<=>?@[]^_{|}�\u201d\u201c';
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
        var regexList = [];var r1;
        var regexEsc = escapeSeparators(),w = "";
        each(errors, function(errorData)
        {
            var errWordRgxVal = errorData["word"].replace(/\s+/g, '[' + regexEsc + ']');
            console.log(errorData);
            console.log(errWordRgxVal);

            if (errorData["pre"] == "") {
                //console.log("Pre doint it: '" + errWordRgxVal + "'");
                errWordRgxVal =  '(?:(.{0})(' + errWordRgxVal + ')(['+regexEsc+']*))';
                //console.log(errWordRgxVal);
                regexList.push(new RegExp('^(?:(.{0})(' + errWordRgxVal + ')(.{0}))', 'gm'));
                //regexList.push(new RegExp('(?:(.{0})(' + errWordRgxVal + ')(.{0}))', 'g'));
            } else {
                errWordRgxVal = '(?:(' + errorData["pre"] + '[' + regexEsc + ']+)(' + errWordRgxVal + ')(['+regexEsc+']))';
                // console.log(errWordRgxVal);/
                regexList.push(new RegExp(errWordRgxVal, 'g'));
            }

            w += (w ? '|' : '') + errWordRgxVal;
        });
        r1 = new RegExp(w);
        console.log(r1);
        console.log(regexList);
        var dom = editor.dom;
        var newContent="";
        var document = editor.getDoc(),walker,node;
        if(document.createTreeWalker){
            walker = document.createTreeWalker(editor.getBody(), NodeFilter.SHOW_TEXT, null, false);
            console.log(walker);
            while((node = walker.nextNode()) != null){
                console.log(node);
                console.log(node.nodeType);
                var nValue = node.nodeValue;
                var newNode = undefined;
                if(node.nodeType==3 && !dom.hasClass("hiddenSpelling")&& !dom.hasClass("hiddenGrammar")&& !dom.hasClass("hiddenEnrich")){
                    nValue = dom.encode(nValue);
                    console.debug('accepted');
                    if (r1.test(nValue)) {
                        each(regexList,function(regex){
                            console.log("B4:"+nValue);
                            console.log('RGX:');
                            console.log(regex);
                            nValue = nValue.replace(regex, "$1<span class='" + errortype + "'>$2</span>$3");
                            newContent+=nValue;
                            console.log("@R:"+newContent);
                            console.log("@R:"+nValue);
                        });
                        newNode = dom.create('span', {'class' : 'mceItemHidden'}, nValue);

                    }
                    console.debug(newNode);
                    if (newNode != undefined){
                        dom.replace(newNode, node);
                    }
                }

            }


        }

        //console.log(newContent);
        //tinymce.activeEditor.setContent(newContent, {format: 'raw'});

    }
    editor.addButton('review', {
        text: 'Review',
        icon: false,
        onclick: function() {
            var walker = new tinymce.dom.TreeWalker('p');

            do {
                console.log(walker.nextNode());
            } while (walker.next());
            editor.suggestions = [];
            editor.setProgressState(1);
            Request_XHR('../ATDWeb/request.php',editor.getContent(),function(xmlString) {
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

                markWords(grammarErrors,"hiddenGrammar");
                markWords(spellingErrors,"hiddenSpelling");
                //markWords(enrichment,"hiddenEnrich");
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