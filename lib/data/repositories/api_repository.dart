import 'dart:convert';

import 'package:api/data/http/exceptions.dart';
import 'package:api/data/http/http_client.dart';
import 'package:api/data/models/api.dart';

abstract class IApiRepository {
  Future <List<ApiModel>> getLayout();
}

class ApiRepository implements IApiRepository{

  final IHttpClient client;

  ApiRepository({required this.client});

  @override
  Future<List<ApiModel>> getLayout()  async{
   final response = await client.get(url: 'https://mock.apidog.com/m1/365912-0-default/layouts',);
  
    if(response.statusCode == 200){
      final List<ApiModel> apis = [];

      final body = jsonDecode(response.body);

      body['products'].map((item){
        final ApiModel model = ApiModel.fromMap(item);
          apis.add(model);
        
      }).toList();
      return apis;   
   
   } else if (response.statusCode == 404){
    throw NotFoundException('A url informada não é válida');
   } else {
    throw Exception('Não foi possível carregar os layouts');
   }
   
  }
}