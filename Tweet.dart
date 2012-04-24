#import('dart:html');
#import('./Tools.dart');
//#import('dart:json');

class Tweet
{
  var _tweet;
  
  Tweet(this._tweet);

createTweetElem()
{
  var id = getTweetId();
  var user = getUser();  //User name
  String tweetText = getTweetText();
  
  //Look for wrapper div
  Element outerDiv = document.body.query('#tweets');
  
  String foo = '';
  
  //Parent div wrapper for a tweet
  Element div = new Element.tag('div');
  //Add wrapper div to body
  
  outerDiv.elements.add(div);
  
  div.attributes = {"class":"tweet","id":"${id}","style":"background-color:#BADA55;padding:10px;margin:5px"};
  
  //Profile pic
  Element pro_pic =new Element.tag('img');
  div.elements.add(pro_pic);
  var img_src = getProfilePic()[0];
  pro_pic.attributes = {'src':img_src};
  
  //Tweet text
  Element text = new Element.tag('p');
  div.elements.add(text);
  
  
  //Add links to links
    var links = getTweetLinks();
    if(links != []) //&& links.length > 0)
    {
      var offset = 0;
      
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
      var offset = 0;
      
      for(int i = 0; i < links.length; i++){
        String linkTxt = Tools.getLinkHtml(Tools.linkHandle(links[i]['screen_name']),'@${links[i]['screen_name']}');
        var offlen = linkTxt.length;
        
        tweetText = tweetText.substring(0,links[i]['indices'][0]+offset) + linkTxt + tweetText.substring(links[i]['indices'][1]+offset);
        offset += offlen - (links[i]['indices'][1]-links[i]['indices'][0]);
        
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

}