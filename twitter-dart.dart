#import('dart:html');
#import('dart:json');

createTweetElem(tweet)
{
  var id = tweet['id'];
  var user = tweet['from_user'];  //User name
  
  //Look for wrapper div
  Element outerDiv = document.body.query('#tweets');
  
  
  String tweetText = tweet['text'];
  String foo = '';
  //Parent div wrapper for a tweet
  Element div = new Element.tag('div');
  //Add wrapper div to body
  
  outerDiv.elements.add(div);
  
  
  div.attributes = {"class":"tweet","id":"${id}","style":"background-color:#BADA55;padding:10px;margin:5px"};
  
  //Profile pic
  Element pro_pic =new Element.tag('img');
  div.elements.add(pro_pic);
  var src = tweet['profile_image_url'];
  pro_pic.attributes = {'src':src};
  
  //Tweet text
  Element text = new Element.tag('p');

  //Add to wrapper div
  div.elements.add(text);
  text.innerHTML = '<b><a href=https://twitter.com/#!/$user>$user</a></b>: $tweetText';
}

dataReceived(e) {
  var data = JSON.parse(e);
  int len = data['results'].length;
  
  //Experimental plot map
  try{
    plot(data['results'][4]['geo']['coordinates'][0],data['results'][4]['geo']['coordinates'][1],"hello world","map");
  }catch(var z){print(z);}
    
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
    createTweetElem(data['results'][i]);
  
  
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

//Experimental plot geo on map
plot(x,y,title,div)
{
Element script = new Element.tag("script");
script.innerHTML="var map = new google.maps.Map(document.getElementById(\"$div\"),{zoom: 12,center: new google.maps.LatLng($x, $y),mapTypeId: google.maps.MapTypeId.ROADMAP});google.maps.event.addListener(map, 'bounds_changed', function() {});var marker = new google.maps.Marker({position: new google.maps.LatLng($x, $y),map: map,title:\"$title\"});";
 document.body.query("#target").elements.add(script);
}



void main() {
  //Set references
	var x=getResponse;
	var y=dataReceived;
	//plot(15.3434,15.1234,"sdsa","dump");
}