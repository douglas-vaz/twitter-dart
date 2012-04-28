class Tools {
  
  static getLinkHtml(String url,[String text])
  {
    if(text != null)
      return '<a href=\"${url}\">$text</a>';
      else
        return  '<a href=\"$url\">$url</a>';
  }
static getClickHtml(String url,[String text])
  {
    if(text != null)
      return '<a href=\"javascript:void(0)\" style="color:blue;" onClick=\"${url}\">$text</a>';
      else
        return  '<a href=\"javascript:void(0)\" style=\"color:blue;\" onClick=\"$url\">$url</a>';
  }
  
  static linkHandle(String handle)
  {
    return 'https://twitter.com/#!/${handle}';
  }
  
}
