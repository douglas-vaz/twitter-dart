#import('dart:html');

class GoogleMaps {
  
  var coordinates;
  var dimensions;
  var marker_color;
  
  GoogleMaps(this.coordinates,this.dimensions,this.marker_color);
  
  String reqUrl()
  {
    String url = "http://maps.googleapis.com/maps/api/staticmap?center=${coordinates[0]},${coordinates[1]}&zoom=12&size=${dimensions[0]}x${dimensions[1]}&markers=color:${marker_color}%7C${coordinates[0]},${coordinates[1]}&sensor=false";
    return url;
  }
  
  Element getimg()
  {
    Element img = new Element.tag('img');
    img.attributes = {'src':'${reqUrl()}'};
    return img;
  }
}