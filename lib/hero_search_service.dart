import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';
import 'package:http/http.dart';

import 'hero.dart';

@Injectable()
class HeroSearchService {
  final Client _http;

  HeroSearchService(this._http);

  Future<List<Hero>> search(String term) async {
    try {
      final response = await _http.get('app/heroes/?name=$term');

      return extractData(response)
          .map((json) => new Hero.fromJson(json))
          .toList();

    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic extractData(Response resp) => JSON.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e); // debugging purposes only
    return new Exception('Server error; cause: $e');
  }
}