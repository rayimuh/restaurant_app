import 'package:mockito/mockito.dart';
import 'package:restaurant_api/model/model.dart';
import 'package:restaurant_api/api/api_service.dart';
import 'package:test/test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import '../test/api_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {  
    test("Check restaurant parsing", () async{
    final client= MockClient();
    when(client.get(Uri.parse("${ApiService.baseUrl}/list"))).thenAnswer((_)async=>http.Response('{"error":false,"message":"success","count":20,"restaurants":[]}',200));
    expect(await ApiService(client: client).loadList(),isA<getList>());
  });  
}
