import 'package:http/http.dart' as http;
import 'package:http/http.dart';

// This webservice class returns a Future<T>
// this allows us to use the same Webservice class to invoke
// diff endpoints and return type of data 

class Resource<T> {
  final String url; 
  T Function(Response response) parse;

  Resource({this.url,this.parse});
}

class Webservice {

  Future<T> load<T>(Resource<T> resource) async {

      final response = await http.get(resource.url);
      if(response.statusCode == 200) {
        return resource.parse(response);
      } else {
        throw Exception('Failed to load data!');
      }
  }

}