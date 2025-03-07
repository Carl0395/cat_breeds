import 'package:flutter_dotenv/flutter_dotenv.dart';

class Routes {
  Routes._();

  static final _domain = dotenv.env['API_URL'];

  static final breeds = '$_domain/breeds';
  static final breedImages = '$_domain/images/search';
}
