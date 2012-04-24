class Tools {
  
  static getLinkHtml(String url,[String text])
  {
    if(text != null)
      return '<a href=\"${url}\">$text</a>';
      else
        return  '<a href=\"$url\">$url</a>';
  }
  
  static linkHandle(String handle)
  {
    return 'https://twitter.com/#!/${handle}';
  }
  
}
