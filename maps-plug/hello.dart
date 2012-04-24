#import('dart:html');
#import('dart:json');
void main()
{
plot('12.3453','35.1223','Waddup','map');
plot('45.3453','35.1223','Waddup too','map2');

Element el = new Element.tag('tag');
document.body.elements.add(el);
el.attributes = {"id":"map3"};

plot('45.3453','35.1223','Waddup too','map3');

}

plot(x,y,title,div)
{
Element script = new Element.tag("script");
script.innerHTML="var map = new google.maps.Map(document.getElementById(\"$div\"),{zoom: 12,center: new google.maps.LatLng($x, $y),mapTypeId: google.maps.MapTypeId.ROADMAP});google.maps.event.addListener(map, 'bounds_changed', function() {});var marker = new google.maps.Marker({position: new google.maps.LatLng($x, $y),map: map,title:\"$title\"});";
 document.body.query("#target").elements.add(script);
}
