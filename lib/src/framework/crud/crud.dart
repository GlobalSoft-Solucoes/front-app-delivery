import 'package:http/http.dart' as http;

class PostJson {
  Future<int> post(urlServidor, route, corpo) async {
    http.Response response = await http.post(
      urlServidor + route,
      headers: {"Content-Type": "application/json"},
      body: corpo,
    );
    return response.statusCode;
  }
}

class PutJson {
  Future<int> put(urlServidor, route, corpo, email) async {
    http.Response response = await http.put(
      Uri.encodeFull(urlServidor + route + email.toString()),
      headers: {"Content-Type": "application/json"},
      body: corpo,
    );
    return response.statusCode;
  }
}
