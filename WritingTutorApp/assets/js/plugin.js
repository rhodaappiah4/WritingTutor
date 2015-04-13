/**
 * Created by HP on 3/17/2015.
 */
var JSONRequest = tinymce.util.JSONRequest, each = tinymce.each, DOM = tinymce.DOM;
var walker = new tinymce.dom.TreeWalker('body');


tinymce.PluginManager.add('WritingTutor', function(editor, url) {

    function Request_XHR(url,reqParam,success){
        tinymce.util.XHR.send({
            url: url+"?analyze=" + encodeURI(reqParam).replace(/&/g, '%26'),
            type: "GET",
            //data: "test=" + encodeURI(reqParam).replace(/&/g, '%26'),
            //content_type : "text/xml",
            success: success,
            error:function(type,req,o ){
                alert( type + "\n" + req.status + "\nAt: " + o.url );
            }
        });
    }
    function escapeSeparators() {
        var escapedWSC = '',
            str = '\\sW!#$%&()*+,-./:;<=>?@[]^_{|}�\u201d\u201c';
        // Build word separator regexp
        for (var i=0; i<str.length; i++)
        {
            escapedWSC += '\\' + str.charAt(i);
        }
        return escapedWSC;
    }
    function removeWords(word){
        console.debug("REM");

        var dom = editor.dom, se = editor.selection, bookmark = se.getBookmark();
        dom.remove(dom.select('div'));
        dom.remove(dom.select('p'),1);
        each(dom.select('span').reverse(), function(n)
        {

            if (n && (dom.hasClass(n, 'error-grammar') || dom.hasClass(n, 'error-spelling') || dom.hasClass(n, 'error-improvement') || dom.hasClass(n, 'mceItemHidden') ))
            {
                if (!word || n.innerHTML == word)
                {
                    dom.remove(n,2);
                }
            }
        });
        console.log(dom.getRoot());
        /* force a rebuild of the DOM... even though the right elements are stripped, the DOM is still organized
         as if the span were there and this breaks my code */
        dom.setHTML(dom.getRoot(), dom.getRoot().innerHTML);

        se.moveToBookmark(bookmark);
        console.debug("/REM");
    }
    function findErrorData(word,pre){
        var found = null;
        each(editor.suggestions,function(error){
            if(error.string === word && error.context == pre){
                found =  error;
                return false;
            }

        });
        return found;
    }
    function markWords(errors, errortype){
        var regexNErrorDataList = [],nodeList = [], r1;
        var regexEsc = escapeSeparators(),w = "";

        each(errors, function(errorData)
        {
            var errWordRgxVal = errorData["word"].replace(/\s+/g, '[' + regexEsc + ']');
            //console.log(errorData);
            //console.log(errWordRgxVal);
            //console.debug(findErrorData(errorData['word'],errorData['pre']));
            if (errorData["pre"] == "") {
                //console.log("Pre doint it: '" + errWordRgxVal + "'");
                errWordRgxVal =  '(?:(.{0})(' + errWordRgxVal + ')(['+regexEsc+']*))';
                //console.log(errWordRgxVal);
                regexNErrorDataList.push({regex:new RegExp('^(?:(.{0})(' + errWordRgxVal + ')(.{0}))', 'gm'),
                    err:findErrorData(errorData['word'],errorData['pre'])});
                //regexNErrorDataList.push(new RegExp('(?:(.{0})(' + errWordRgxVal + ')(.{0}))', 'g'));
            } else {
                errWordRgxVal = '(?:(' + errorData["pre"] + '[' + regexEsc + ']+)(' + errWordRgxVal + ')(['+regexEsc+']))';
                // console.log(errWordRgxVal);/
                regexNErrorDataList.push({regex: new RegExp(errWordRgxVal, 'g'),
                    err:findErrorData(errorData['word'],errorData['pre'])});
            }

            w += (w ? '|' : '') + errWordRgxVal;
        });
        r1 = new RegExp(w);
        var dom = editor.dom;

        var document = editor.getDoc(),walker,node;
        if(document.createTreeWalker){
            walker = document.createTreeWalker(editor.getBody(), NodeFilter.SHOW_TEXT, null, false);
            while((node = walker.nextNode()) != null){
                if(node.nodeType==3 && !dom.hasClass("error-spelling")&& !dom.hasClass("error-grammar")&& !dom.hasClass("error-improvement")){
                        nodeList.push(node);
                }
            }
            each(nodeList,function(node){
                if(node.nodeType == 3) {
                    var nValue = node.nodeValue;
                    var newNode;
                    //console.log(node);
                    nValue = dom.encode(nValue);
                   // if (r1.test(nValue)) {
                        each(regexNErrorDataList, function (regex) {
                            var errdata = regex.err;
                            regex = regex.regex;

                            //console.log("B4:" + nValue);
                            //console.log('RGX:');
                            //console.log(regex);
                           // nValue = nValue.replace(regex, "$1<span pre='$1' class='" + errortype + "'>$2</span>$3 ");
                            nValue = nValue.replace(regex, "$1<span pre='$1' class='" + errortype + "'>"+
                            '<div class="feedback">'+
                            '<div class="header">Error description</div>'+
                            '<div class="description">'+
                                errdata.description +
                            '</div>'+
                            //
                            '<div class="header">Suggestions</div>'+
                            '<div class="suggestions">'+
                                 errdata.suggestions.join(",") +
                            '</div>'+
                            //
                            '<div class="header">Explanation</div>'+
                            '<div class="explanation">'+
                            '<div class="url">' +
                            //urldata+
                            '</div>'+
                            '</div>'+
                            '</div>' +
                            //
                            '$2</span>$3 ');
                            //console.log("@R:" + nValue);
                        });
                        newNode = dom.create('span', null, nValue);
                   // }
                }
                //console.debug(newNode);
                if (newNode != undefined){
                    dom.replace(newNode, node);
                }
                dom.remove('.mceItemHidden');
            });


    }

    //console.log(newContent);
    //tinymce.activeEditor.setContent(newContent, {format: 'raw'});

}

editor.addButton('review', {
    text: 'Review',
    icon: false,
    onclick: function() {

        editor.suggestions = [];
        editor.setProgressState(1);
        removeWords();
        Request_XHR('../ATDWeb/request.php',editor.getContent(),function(xmlString) {
            xmlString = xmlString.replace(/\"$/,"");
            console.log(xmlString);
            xmlString = $.parseXML(xmlString.substr(xmlString.indexOf('<'),xmlString.lastIndexOf('>')+1));

            var grammarErrors    = [];
            var spellingErrors   = [];
            var enrichment       = [];

            $(xmlString).find('error').each(function(key,value){
                var errorString      = $(value).find('string').text();
                var errorType        = $(value).find('type').text();
                var errorDescription = $(value).find('description').text();
                var errorContext = ($(value).find('precontext') != undefined)?
                    $(value).find('precontext').text():"";

                var errorDataSet = {};
                errorDataSet["description"] = errorDescription;
                errorDataSet["suggestions"] = [];
                //errorDataSet["matcher"]     = new RegExp(errorString.replace(/\s+/, '[' + plugin._getSeparators() + ']'));
                errorDataSet["context"]     = errorContext;
                errorDataSet["string"]      = errorString;
                errorDataSet["type"]        = errorType;
                editor.setProgressState(0);

                if ($(value).find('suggestions') != undefined){
                    var suggestions =  $(value).find('suggestions').find('option');
                    for (j = 0; j < suggestions.length; j++){
                        errorDataSet["suggestions"].push($(suggestions[j]).text());
                    }
                }

                //TODO: setup url for explanation
                //* setup the more info url */
                //if (errors[i].getElementsByTagName('url').item(0) != undefined)
                //{
                //    var errorUrl = errors[i].getElementsByTagName('url').item(0).firstChild.data;
                //    var theme    = editor.getParam("atd_theme", "tinymce");
                //    errorDataSet["moreinfo"] = errorUrl + '&theme=' + theme;
                //    //console.log(errorUrl);
                //}

                editor.suggestions.push(errorDataSet);
                if (errorType == "errorDataSet")
                    enrichment.push({ word: errorString, pre: errorContext });

                if (errorType == "grammar")
                    grammarErrors.push({ word: errorString, pre: errorContext });

                if (errorType == "spelling" || errorDescription == "Homophone")
                    spellingErrors.push({ word: errorString, pre: errorContext });

            });

            markWords(grammarErrors,"error-grammar");
            markWords(spellingErrors,"error-spelling");
            markWords(enrichment,"error-improvement");
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