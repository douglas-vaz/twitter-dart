#import('dart:html');
#import('./Tools.dart');
#import('./maps-plug/GoogleMaps.dart');

class Tweet
{
  var _tweet;
  
  Tweet(this._tweet);

createTweetElem(String wrapDivId)
{
  var id = getTweetId();
  var user = getUser();  //User name
  String tweetText = getTweetText();
  var geo = getTweetGeo();
  
  Element map = null;
  if(geo != null)
  {
    map = new GoogleMaps(geo,[150,150],'blue').getimg();
  }
  
  //Look for wrapper div
  Element outerDiv = document.body.query('#${wrapDivId}');
  
  String foo = '';
  
  //Parent div wrapper for a tweet
  Element div = new Element.tag('div');
  //Add wrapper div to body
  
  outerDiv.elements.add(div);
  
  div.attributes = {"class":"tweet","id":"${id}","style":"background-color:#BADA55;padding:10px;margin:5px"};
  
  //Profile pic
  //Element pro_pic =new Element.tag('img');
  //div.elements.add(pro_pic);
  var img_src = getProfilePic()[0];
  //pro_pic.attributes = {'src':img_src};
  
  var img = '<img src=\"${img_src}\" />';
  div.innerHTML += Tools.getLinkHtml(getProfilePic()[1],img);
  
  //Tweet text
  Element text = new Element.tag('p');
  div.elements.add(text);
  
  
  //Add map
  if(map != null)
    div.elements.add(map);
  var offset = 0;
  //Add links to links
    var links = getTweetLinks();
    if(links != []) //&& links.length > 0)
    {
      
      for(int i = 0; i < links.length; i++){
        String linkTxt = Tools.getLinkHtml(links[i]['url'],links[i]['display_url']);
        var offlen = linkTxt.length;
        
        tweetText = tweetText.substring(0,links[i]['indices'][0]+offset) + linkTxt + tweetText.substring(links[i]['indices'][1]+offset);
        offset += offlen - (links[i]['indices'][1]-links[i]['indices'][0]);
        
      }
    }
    
    //Add links to mentions
    links = getTweetMentions();
    if(links != [])
    {
      //var offset = 0;
      
      for(int i = 0; i < links.length; i++){
        String linkTxt = Tools.getLinkHtml(Tools.linkHandle(links[i]['screen_name']),'@${links[i]['screen_name']}');
        var offlen = linkTxt.length;
        
        tweetText = tweetText.substring(0,links[i]['indices'][0]+offset) + linkTxt + tweetText.substring(links[i]['indices'][1]+offset);
        offset += offlen - (links[i]['indices'][1]-links[i]['indices'][0]);
        
      }
    }
//Add links to hashtags
  var hash=getTweetHashtag();
  if(hash != [])
    {
      //var offset = 0;
      
      for(int i = 0; i < hash.length; i++){
        String linkTxt = Tools.getClickHtml("getResponse('${hash[i]['text']}');document.getElementById('search').value='#${hash[i]['text']}';",'#${hash[i]['text']}');
        var offlen = linkTxt.length;
        
        tweetText = tweetText.substring(0,hash[i]['indices'][0]+offset) + linkTxt + tweetText.substring(hash[i]['indices'][1]+offset);
        offset += offlen - (hash[i]['indices'][1]-hash[i]['indices'][0]);
        
      }
    }
  text.innerHTML = '<b><a href=${user[1]}>${user[0]}</a></b>: $tweetText';
}


/*
*returns [user handle, link to user profile]
*/
getUser()
{
  var userinfo = [_tweet['from_user'],'https://twitter.com/#!/${_tweet['from_user']}'];
  return userinfo;
}

getTweetId()
{
  return _tweet['id'];
}

getTweetGeo()
{
  try{
    return _tweet['geo']['coordinates'];
  }
  catch(var e)
  {
    return null;
  }
}

getTweetLinks()
{
  return _tweet['entities']['urls'];
}

getTweetText()
{
  return _tweet['text'];
}

/*
*returns [profile pic, original profile pic]
*/
getProfilePic()
{
  var user = _tweet['from_user']; 
  var pic = [_tweet['profile_image_url'],'https://api.twitter.com/1/users/profile_image?screen_name=${user}&size=original'];
  
  return pic;
}

getTweetMentions()
{
  return _tweet['entities']['user_mentions'];
}
getTweetHashtag()
{
  return _tweet['entities']['hashtags'];
}

}
