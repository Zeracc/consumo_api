import 'package:api/data/http/exceptions.dart';
import 'package:api/data/models/api.dart';
import 'package:api/data/repositories/api_repository.dart';
import 'package:flutter/material.dart';

class LayoutStore {
  final IApiRepository repository;
  //variavel para o loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  //variávek reativa para o state
  final ValueNotifier<List<ApiModel>> state = ValueNotifier<List<ApiModel>>([]);

  //variável reativa para o erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  LayoutStore({required this.repository});

 Future getApi() async{
    isLoading.value =true;
    try{
      final result = await repository.getLayout();
      state.value = result;
    } on NotFoundException catch(e){
      erro.value = e.message;
    }
    catch(e){
      erro.value = e.toString();
    } 

    isLoading.value = false;
  }
}