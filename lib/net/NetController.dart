import 'dart:convert';
import 'dart:io';

class NetController {
  static void request(String url, Function callback,
      {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    HttpClientResponse response;
    HttpClientRequest request;
    var responseBody;
    try {
      var httpClient = new HttpClient();
      request = await httpClient.getUrl(Uri.parse(url));
      response = await request.close();
      var responseCode = response.statusCode;
      responseBody = await response.transform(utf8.decoder).join();
    } catch (exception) {}
    if (callback != null) {
      callback(request, response,responseBody);
    }
  }
}
