
$(document).ready(function(){
    //Do we need to initialise anything here?
});

function uploadDictionary()
{
    var files = $('#dictionary').get(0).files;
    var reader  = new FileReader();
    var data;
    reader.onload = function(event) {
        
        var content = event.target.result;
        //content = content.replace(/\n/g, ",");
        var ajaxTime= new Date().getTime();
        $.ajax({
            //type: "GET",
	    type: "POST",
            contentType:  "multipart/form-data",
            url: "/dictionary_api/create.json",
            cache: false,
            dataType:'json',
            data: 'dictionary=' + content,
            //data: content,
            async:  false,
            success: function(data)
            {
                var message = ""
                for(var i =0;i < data.length;i++)
                {
                    var item = data[i];
                    var obj = jQuery.parseJSON(item);
                    message = obj.message;
                }
                //alert(message);

                //Here we'll swap out the contents of the div we care about
                var pattern = /we\sgood/;
                var OK = pattern.exec(message); 
                if (!OK)
                {
                    $('#dict')[0].innerHTML="<div class=\"uploadPartial\"><h4 id=\"uploadTime\">Dictionary Uploaded. "+message+". </h4><p>These words may already be in the dictionary or may be invalid. Please ensure all words in your dictionary do not contain numbers or punctuation</p></div>";

                }
                else
                {
                    $('#dict')[0].innerHTML="<div class=\"uploadSuccess\"><h4 id=\"uploadTime\">Dictionary Upload Success!</h4></div>";
                }
                
            }
        }).done(function () {
            var totalTime = new Date().getTime()-ajaxTime;
            $('#uploadTime')[0].innerHTML+="&nbsp;Uploaded in "+totalTime+"ms";
        }); //End of Ajax
        //alert(content)
        return content
    }
    
    data = reader.readAsText(files[0]);
}

function requestAnagrams()
{
    var word = $('#word').val()
    var ajaxTime= new Date().getTime();
    $.ajax({
        type: "GET",
        url: "/anagram_api/show.json",
        cache: false,
        dataType:'json',
        data: 'word=' + word,
        async:  false,
        success: function(response)
        {
            var words_string = ""
            for(var i =0;i < response.length;i++)
            {
                var item = response[i];
                var obj = jQuery.parseJSON(item);
                words_string = words_string + " "+ obj.word;
            }
            //alert(words_string)
            //Here we'll swap out the contents of the div we care about
            var totalTime = new Date().getTime()-ajaxTime;
            if(response.length == 0)
            {
	            $('#anagramResults')[0].innerHTML="<div class=\"noResult\">Query string <h4>"+word+"</h4> found no anagrams <br />Response time was "+totalTime+"ms.</div><br />"+$('#anagramResults')[0].innerHTML;
            }
            else
            {
           		$('#anagramResults')[0].innerHTML="<div class=\"anagramResult\">Query string <h4>"+word+"</h4> found the following anagrams: <br /><h4>"+words_string+"</h4>Response time was "+totalTime+"ms.</div><br />"+$('#anagramResults')[0].innerHTML;
		   }
        }
        }); //End of Ajax
    //alert(content)
}

