class NYTapi {

  /* This class constructs requests to the NYT APIs. 
   ---------------------------------------------------------------- */

  String baseURL = "http://api.nytimes.com/svc/";
  String apikey, apiurl;
  NYTapi(String _apikey, String _apiurl) {
    apikey = "api-key=" + _apikey;
    apiurl = _apiurl;
  }

  XML getQuery(String service) { // if query only takes service
    String url =  baseURL + apiurl + service + "?" + apikey;
    return loadXML(url);
  }

  // if query takes both service and additional parameters
  XML getQuery(String service, String[] params) {
    String url =  baseURL + apiurl + service + "?";
    for (int i = 0; i < params.length; i++) {
      url = url + params[i] + "&";
    }
    url = url + apikey;
    return loadXML(url);
  }
}

