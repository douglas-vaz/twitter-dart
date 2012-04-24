#import('dart:html');
#import('dart:json');
#import('./Tweet.dart');


dataReceived(e) {
  var data = JSON.parse(e);
  int len = data['results'].length;
  
  //document.query("#dump").innerHTML = data['results'][4]['geo']['coordinates'][0];
  
  try{
    for(var i = 0; i < data['results'][0]['entities']['urls'].length; i++){
      var exurl = data['results'][0]['entities']['urls'][i]['expanded_url'];
      //document.query("#dump").innerHTML += '<a href=\"${exurl}\">${exurl}</a><br>';//[0];
    }
  }
  catch(var z)
  {
    print(z);
  }
  
  //DOM cleanup
  try{
  document.body.query('#tweets').remove();
  }
  catch(var ex)
  {
    print(ex.toString());
  }
  
  //Create wrapper div
  Element outerDiv = new Element.tag('div');
  document.body.elements.add(outerDiv);
  outerDiv.attributes = {"id":"tweets"};
  
  //Add all tweets from response to the DOM
  for (int i = 0; i < len; ++i)
    new Tweet(data['results'][i]).createTweetElem(); 
  
}

write(String message,String str,int i) {
String o="#".concat(str);
  document.query(o.concat(i.toString())).innerHTML = message;
}

getResponse(String query)
{
	//write(query,'status',0);
  Element script = new Element.tag("script");
  script.attributes ={"src": "http://search.twitter.com/search.json?q=$query&callback=callbackForJsonpApi&include_entities=true"};
  document.body.elements.add(script);
  
  //clean
  script.remove();

}


void main() {
  //Set references
	var x=getResponse;
	var y=dataReceived;
	//plot(15.3434,15.1234,"sdsa","dump");
}